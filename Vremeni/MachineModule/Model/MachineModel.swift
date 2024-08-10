//
//  MachineModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import Foundation
import SwiftData

// MARK: - MachineItem

@Model
final class MachineItem: Identifiable {
    var id = UUID()
    var name: String
    var itemDescription: String
    var image: String
    
    var price: Float
    var percent: Double
    var inProgress: Bool
    
    var type: VremeniType
    var rarity: Rarity
    var parent: ConsumableItem
    
    var started: Date = Date()
    var target: Date = Date()
    
    init(id: UUID = UUID(), name: String, itemDescription: String, image: String, price: Float, percent: Double = 0, inProgress: Bool = false, type: VremeniType = .minutes, rarity: Rarity = .common, parent: ConsumableItem) {
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

extension MachineItem {
    internal func readyToggle() {
        parent.ready = true
        parent.countPlus()
        inProgress = false
    }
    
    internal func progressStart() {
        inProgress = true
    }
    
    internal func progressDismiss() {
        inProgress = false
    }
    
    internal func setMachineTime() {
        if percent == 0 {
            started = .now
            target = .now.addingTimeInterval(TimeInterval(price * 60))
        } else {
            let passedTime = TimeInterval((price * 60) * Float(percent / 100))
            let remainTime = (price * 60) * Float(1 - percent / 100)
            started = .now.addingTimeInterval(-passedTime)
            target = .now.addingTimeInterval(TimeInterval(remainTime))
        }
    }
    
    static internal func itemMockConfig(name: String, description: String = String(), price: Float, inProgress: Bool = false, rarity: Rarity = .common) -> MachineItem {
        let name = name
        let description = description
        let image = "\(Int(price)).square"
        let price = price
        let rarity = rarity
        let parent = ConsumableItem.itemMockConfig(name: name, price: price)
        
        return MachineItem(name: name, itemDescription: description, image: image, price: price, rarity: rarity, parent: parent)
    }
}

