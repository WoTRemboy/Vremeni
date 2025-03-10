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
    case exotic = "Exotic"
    case final = "Final"
}

// MARK: - Rarity Methods

extension Rarity: Identifiable {
    internal var id: Self { self }
    
    // Case iterable method, but without .all
    static internal var allCases: [Rarity] {
        return [.common, .uncommon, .rare, .epic, .legendary, .mythic, .exotic, .final]
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
        case .exotic:
            Texts.Rarity.exotic
        case .final:
            Texts.Rarity.final
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
        case .exotic:
            return .Rarity.exotic
        case .final:
            return .Rarity.final
        }
    }
    
    internal var whiteImage: Image {
        switch self {
        case .common:
            return .Rarity.White.common
        case .uncommon:
            return .Rarity.White.uncommon
        case .rare:
            return .Rarity.White.rare
        case .epic:
            return .Rarity.White.epic
        case .legendary:
            return .Rarity.White.legendary
        case .mythic:
            return .Rarity.White.mythic
        case .exotic:
            return .Rarity.White.exotic
        case .final:
            return .Rarity.White.final
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
        case .exotic:
            Color.RarityColors.exotic
        case .final:
            Color.RarityColors.final
        }
    }
    
    internal func compareRarity(for filter: Self) -> Bool {
        switch self {
        case .common:
            filter == .common
        case .uncommon:
            filter == .uncommon
        case .rare:
            filter == .rare
        case .epic:
            filter == .epic
        case .legendary:
            filter == .legendary
        case .mythic:
            filter == .mythic
        case .exotic:
            filter == .exotic
        case .final:
            filter == .final
        }
    }
}
