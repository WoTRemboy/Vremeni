//
//  RarityModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/9/24.
//

import Foundation
import SwiftUI

// MARK: - Rarity

enum Rarity: String, Codable, Identifiable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    case mythic = "Mythic"
    case transcendent = "Transcendent"
    case exotic = "Exotic"
    case all = "All"
    
    var id: Self { self }
    
    static var allCases: [Rarity] {
        return [.common, .uncommon, .rare, .epic, .legendary, .mythic, .transcendent, .exotic]
    }
    
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
        case .all:
            return Image("")
        }
    }
}
