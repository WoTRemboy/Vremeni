//
//  RarityModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/9/24.
//

import Foundation
import SwiftUI

// MARK: - Rarity Model

enum Rarity: String, Codable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    case mythic = "Mythic"
    case transcendent = "Transcendent"
    case exotic = "Exotic"
    case all = "All"
}

// MARK: - Rarity Methods

extension Rarity: Identifiable {
    internal var id: Self { self }
    
    // Case iterable method, but without .all
    static internal var allCases: [Rarity] {
        return [.common, .uncommon, .rare, .epic, .legendary, .mythic, .transcendent, .exotic]
    }
    
    // Rarity name definition
    internal var name: String {
        switch self {
        case .common:
            Texts.Rarity.common
        case .uncommon:
            Texts.Rarity.uncommon
        case .rare:
            Texts.Rarity.rare
        case .epic:
            Texts.Rarity.epic
        case .legendary:
            Texts.Rarity.legendary
        case .mythic:
            Texts.Rarity.mythic
        case .transcendent:
            Texts.Rarity.transcendent
        case .exotic:
            Texts.Rarity.exotic
        case .all:
            Texts.Rarity.all
        }
    }
    
    // Rarity icon definition
    internal var image: Image {
        switch self {
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
    
    // Rarity color definition
    internal var color: Color {
        switch self {
        case .common:
            Color.RarityColors.common
        case .uncommon:
            Color.RarityColors.uncommon
        case .rare:
            Color.RarityColors.rare
        case .epic:
            Color.RarityColors.epic
        case .legendary:
            Color.RarityColors.legendary
        case .mythic:
            Color.RarityColors.mythic
        case .transcendent:
            Color.RarityColors.transcendent
        case .exotic:
            Color.RarityColors.exotic
        case .all:
            Color.RarityColors.common
        }
    }
}
