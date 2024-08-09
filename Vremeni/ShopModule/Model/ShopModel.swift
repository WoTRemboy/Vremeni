//
//  ShopModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftUI
import SwiftData

// MARK: - ConsumableItem

@Model
final class ConsumableItem: Identifiable {
    var id = UUID()
    var name: String
    var itemDescription: String
    var image: String
    
    var price: Float
    var count: Int
    
    var type: VremeniType
    var rarity: Rarity
    @Relationship(deleteRule: .cascade) var machineItems: [MachineItem]
    
    var enabled: Bool
    var inMachine: Bool
    var ready: Bool
    var archived: Bool
    
    init(id: UUID = UUID(), name: String, itemDescription: String, image: String, price: Float, count: Int = 0, type: VremeniType = .minutes, rarity: Rarity = .common, machineItems: [MachineItem] = [], enabled: Bool = false, inMachine: Bool = false, ready: Bool = false, archived: Bool = false) {
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

extension ConsumableItem {
    
    internal func unlockItem() {
        enabled = true
    }
    
    internal func addToMachine() {
        let child = MachineItem(name: name, itemDescription: itemDescription, image: image, price: price, rarity: rarity, parent: self)
        machineItems.append(child)
        inMachine = true
    }
    
    internal func countPlus() {
        count += 1
    }
    
    static internal func itemMockConfig(name: String, description: String = String(), price: Float, rarity: Rarity = .common, enabled: Bool = true, ready: Bool = false) -> ConsumableItem {
        let name = name
        let description = description
        let image = "\(Int(price)).square"
        let price = price
        let enable = enabled
        let ready = ready
        let rarity = rarity
        
        return ConsumableItem(name: name, itemDescription: description, image: image, price: price, rarity: rarity, enabled: enable, ready: ready)
    }
}

// MARK: - Type

enum VremeniType: String, Codable {
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    case weeks = "Weeks"
    case months = "Months"
    case year = "Year"
    case special = "Special"
}
