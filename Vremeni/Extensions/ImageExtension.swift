//
//  ImageExtension.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI

extension Image {
    enum ShopPage {
        static let vCoin = Image("VCoin")
        static let filter = Image(systemName: "line.3.horizontal.decrease.circle")
        static let filledFilter = Image(systemName: "line.3.horizontal.decrease.circle.fill")
    }
    
    enum InventoryPage {
        static let count = Image(systemName: "x.circle.fill")
    }
    
    enum ProfilePage {
        static let about = Image("AboutIcon")
    }
    
    enum Rarity {
        static let common = Image("RarityCommon")
        static let uncommon = Image("RarityUncommon")
        static let rare = Image("RarityRare")
        static let epic = Image("RarityEpic")
        static let legendary = Image("RarityLegendary")
        static let mythic = Image("RarityMythic")
        static let exotic  = Image("RarityExotic")
        static let transcendent = Image("RarityTranscendent")
    }
    
    enum TabBar {
        static let shop = Image(systemName: "creditcard.and.123")
        static let machine = Image(systemName: "clock.arrow.2.circlepath")
        static let inventory = Image(systemName: "amplifier")
        static let profile = Image(systemName: "person")
    }
    
    enum Placeholder {
        static let placeholder1to1 = Image("Placeholder1to1")
    }
}
