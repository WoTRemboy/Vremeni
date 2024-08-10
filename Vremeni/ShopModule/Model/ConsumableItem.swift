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
    var name: String
    var itemDescription: String
    var image: String
    
    // Valuation
    var price: Float
    var count: Int
    
    // Item type
    var type: VremeniType
    var rarity: Rarity
    
    // Instanses (children) for machine module
    @Relationship(deleteRule: .cascade) var machineItems: [MachineItem]
    
    // Item status
    var enabled: Bool
    var inMachine: Bool
    var ready: Bool
    var archived: Bool
    
    init(id: UUID = UUID(), name: String, itemDescription: String, image: String,
         price: Float, count: Int = 0, type: VremeniType = .minutes, rarity: Rarity = .common,
         machineItems: [MachineItem] = [], enabled: Bool = false, inMachine: Bool = false,
         ready: Bool = false, archived: Bool = false) {
        self.id = id
        self.name = name
        self.itemDescription = itemDescription
        self.image = image
        self.price = price
        self.count = count
        self.type = type
        self.rarity = rarity
        self.machineItems = machineItems
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
    
    // Mock ConsumableItem configuration method
    static internal func itemMockConfig(name: String, description: String = String(),
                                        price: Float, rarity: Rarity = .common,
                                        enabled: Bool = true, ready: Bool = false) -> ConsumableItem {
        let name = name
        let description = description
        let image = "\(Int(price)).square"
        let price = price
        let enable = enabled
        let ready = ready
        let rarity = rarity
        
        return ConsumableItem(name: name, itemDescription: description, image: image,
                              price: price, rarity: rarity, enabled: enable, ready: ready)
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
