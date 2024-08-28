//
//  MachineModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import Foundation
import SwiftData

// MARK: - MachineItem Model

@Model
final class MachineItem: Identifiable {
    
    // General
    var id = UUID()
    var name: String
    var itemDescription: String
    var image: String
    
    // Valuation
    var price: Float
    // Progress status
    var percent: Double
    var inProgress: Bool
    
    // MashineItem type
    var type: VremeniType
    var rarity: Rarity
    // Data base relationship
    var parent: ConsumableItem
    
    // Progress checks
    var started: Date = Date()
    var target: Date = Date()
    
    init(id: UUID = UUID(), name: String, itemDescription: String, image: String,
         price: Float, percent: Double = 0, inProgress: Bool = false,
         type: VremeniType = .minutes, rarity: Rarity = .common, parent: ConsumableItem) {
        self.id = id
        self.name = name
        self.itemDescription = itemDescription
        self.image = image
        self.price = price
        self.percent = percent
        self.inProgress = inProgress
        self.type = type
        self.rarity = rarity
        self.parent = parent
    }
}

// MARK: - MachineItem Methods

extension MachineItem {
    // Changes to ready when workshop status is 100%
    internal func readyToggle() {
        parent.ready = true
        // Adds item valuation to Profile balance
        parent.countPlus()
        inProgress = false
    }
    
    // Begins workshop processing
    internal func progressStart() {
        inProgress = true
    }
    
    // Ends/Cancels workshop processing
    internal func progressDismiss() {
        inProgress = false
    }
    
    // Sets start and target dates
    internal func setMachineTime() {
        // When it's first time
        if percent == 0 {
            started = .now
            target = .now.addingTimeInterval(TimeInterval(price * 60))
        // Resumes after pause
        } else {
            let passedTime = TimeInterval((price * 60) * Float(percent / 100))
            let remainTime = (price * 60) * Float(1 - percent / 100)
            started = .now.addingTimeInterval(-passedTime)
            target = .now.addingTimeInterval(TimeInterval(remainTime))
        }
    }
    
    // Configurates MachineItem mock data
    static internal func itemMockConfig(name: String, description: String = String(),
                                        price: Float, inProgress: Bool = false,
                                        rarity: Rarity = .common, profile: Profile) -> MachineItem {
        let name = name
        let description = description
        let image = "\(Int(price)).square"
        let price = price
        let rarity = rarity
        let profile = profile
        let parent = ConsumableItem.itemMockConfig(nameKey: name, price: price, profile: profile)
        
        return MachineItem(name: name, itemDescription: description, image: image, price: price, rarity: rarity, parent: parent)
    }
}

// MARK: - Workshop upgrade Model

enum UpgrageMethod: String {
    case coins = "Local currency"
    case money = "Real currency"
    
    internal var name: String {
        switch self {
        case .coins:
            Texts.MachinePage.Upgrade.coins
        case .money:
            Texts.MachinePage.Upgrade.real
        }
    }
}
