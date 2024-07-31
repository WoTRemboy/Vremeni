//
//  Lables.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

final class Texts {
    enum Common {
        static let title = "Vremeni"
    }
    
    enum Rarity {
        static let common = "Common"
        static let uncommon = "Uncommon"
        static let rare = "Rare"
        static let epic = "Epic"
        static let legendary = "Legendary"
        static let mythic = "Mythic"
        static let transcendent = "Transcendent"
        static let exotic = "Exotic"
    }
    
    enum ShopPage {
        static let title = "Fair"
        static let addItem = "Add"
        static let addToMachine = "Add to Machine"
    }
    
    enum ItemCreatePage {
        static let title = "New Item"
        static let details = "Details"
        static let cancel = "Cancel"
        static let save = "Save"
        
        static let price = "Price"
        static let minPrice = "1"
        static let maxPrice = "50"
        static let total = "Total"
        
        static let general = "General"
        static let name = "Name"
        static let description = "Description"
        static let rarity = "Rarity"
        static let valuation = "Valuation"
        static let turnover = "Turnover (Soon)"
        static let receiveRules = "Receive rules"
        static let applicationRules = "Application rules"
        static let null = "Null"
    }
    
    enum MachinePage {
        static let title = "Machine"
        static let progress = "Progress"
        static let completed = "Completed"
    }
    
    enum InventoryPage {
        static let title = "Inventory"
    }
    
    enum ProfilePage {
        static let title = "Profile"
        static let version = "Version"
        static let release = "release"
    }
    
    enum TotalPrice {
        static let total = "Total"
    }
}
