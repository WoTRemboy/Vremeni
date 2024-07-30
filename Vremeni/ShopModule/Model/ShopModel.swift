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
    var image: String
    var price: Int
    var rarity: Rarity
    var added: Date
    var started: Date
    var target: Date
    var inProgress: Bool
    var ready: Bool
    
    init(name: String, image: String, price: Int, rarity: Rarity = .common, added: Date, started: Date, target: Date, inProgress: Bool = false, ready: Bool = false) {
        self.name = name
        self.image = image
        self.price = price
        self.rarity = rarity
        self.added = added
        self.started = started
        self.target = target
        self.inProgress = inProgress
        self.ready = ready
    }
}

extension ConsumableItem {
    internal func readyToggle() {
        ready = true
        inProgress = false
    }
    
    internal func progressToggle() {
        ready = false
        inProgress = true
    }
    
    internal func setMachineTime() {
        started = .now
        target = .now.addingTimeInterval(TimeInterval(price * 60))
    }
    
    static internal func itemMockConfig(name: String, price: Int, rarity: Rarity = .common) -> ConsumableItem {
        let name = name
        let image = "\(price).square"
        let price = price
        let rarity = rarity
        let added = Date.now
        let started = Date.now
        let target = added.addingTimeInterval(TimeInterval(price * 60))
        
        return ConsumableItem(name: name, image: image, price: price, rarity: rarity, added: added, started: started, target: target)
    }
}

// MARK: - Rarity

enum Rarity: String, Codable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    case mythic = "Mythic"
    case transcendent = "Transcendent"
    case exotic = "Exotic"
    
    static func rarityToImage(rarity: Rarity) -> Image {
        switch rarity {
        case .common:
            return .Rarity.common
        case .uncommon:
            return .Rarity.uncommon
        case .rare:
            return .Rarity.rare
        case .epic:
            return .Rarity.epic
        case .legendary:
            return .Rarity.legendary
        case .mythic:
            return .Rarity.mythic
        case .transcendent:
            return .Rarity.transcendent
        case .exotic:
            return .Rarity.exotic
        }
    }
}
