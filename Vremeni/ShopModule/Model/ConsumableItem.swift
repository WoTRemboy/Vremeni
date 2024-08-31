//
//  ConsumableItem.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - ConsumableItem Model

@Model
final class ConsumableItem: Identifiable {
    
    // General
    var id = UUID()
    var nameKey: String
    var descriptionKey: String
    var image: String
    
    // General localized
    var name: String {
        NSLocalizedString(nameKey, comment: String())
    }
    var itemDescription: String {
        NSLocalizedString(descriptionKey, comment: String())
    }
    
    // Valuation
    var price: Float
    var count: Int
    
    // Item type
    var type: VremeniType
    var rarity: Rarity
    
    // Research requirements
    var requirement: [String: Int]
    
    // Instanses (children) for machine module
    @Relationship(deleteRule: .cascade) var machineItems: [MachineItem]
    
    // Child relationship for Profile
    var profile: Profile
    
    // Item status
    var enabled: Bool
    var inMachine: Bool
    var ready: Bool
    var archived: Bool
    
    init(id: UUID = UUID(), nameKey: String, descriptionKey: String,
         image: String, price: Float, count: Int = 0, type: VremeniType = .minutes,
         rarity: Rarity = .common, machineItems: [MachineItem] = [],
         profile: Profile, requirement: [String: Int],
         enabled: Bool = false, inMachine: Bool = false,
         ready: Bool = false, archived: Bool = false) {
        
        self.id = id
        self.nameKey = nameKey
        self.descriptionKey = descriptionKey
        self.image = image
        self.price = price
        self.count = count
        self.type = type
        self.rarity = rarity
        self.machineItems = machineItems
        self.profile = profile
        self.requirement = requirement
        self.enabled = enabled
        self.inMachine = inMachine
        self.ready = ready
        self.archived = archived
    }
}

// MARK: - ConsumableItem Methods

extension ConsumableItem {
    
    // Transition from locked to available status (Shop Module)
    internal func unlockItem() {
        enabled = true
    }
    
    // Changes archive status (Shop & Profile Modules)
    internal func archiveItem() {
        archived.toggle()
    }
    
    // Creating a MachineItem instanse and adding it to the Machine (Shop Module)
    internal func addToMachine() {
        let child = MachineItem(name: name, itemDescription: itemDescription, image: image,
                                price: price, rarity: rarity, parent: self)
        machineItems.append(child)
        inMachine = true
    }
    
    // After the child is ready, the parent's count increases by one (Machine Module)
    internal func countPlus() {
        count += 1
    }
    
    // Reduces item's count when other item unlocks
    internal func reduceCount(for price: Int) {
        count -= price
    }
    
    // Mock ConsumableItem configuration method
    static internal func itemMockConfig(nameKey: String, descriptionKey: String = String(),
                                        price: Float, count: Int = 0,
                                        rarity: Rarity = .common,
                                        profile: Profile, requirement: [String: Int] = [:],
                                        enabled: Bool = true,
                                        ready: Bool = false, archived: Bool = false) -> ConsumableItem {
        let nameKey = nameKey
        let descriptionKey = descriptionKey
        let image = "\(Int(price)).square"
        let price = price
        let count = count
        let enable = enabled
        let ready = ready
        let archived = archived
        let rarity = rarity
        let profile = profile
        let requirement = requirement
        
        return ConsumableItem(nameKey: nameKey, descriptionKey: descriptionKey,
                              image: image, price: price, count: count, rarity: rarity,
                              profile: profile, requirement: requirement, enabled: enable, ready: ready,
                              archived: archived)
    }
}

// MARK: - ConsumableItem Type

enum VremeniType: String, Codable {
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    case weeks = "Weeks"
    case months = "Months"
    case year = "Year"
    case special = "Special"
}

enum ResearchType {
    case completed
    case locked
    case less
    
    internal var icon: Image {
        switch self {
        case .completed:
            Image.ShopPage.Research.check
        case .locked:
            Image.ShopPage.Research.locked
        case .less:
            Image.ShopPage.Research.less
        }
    }
}
