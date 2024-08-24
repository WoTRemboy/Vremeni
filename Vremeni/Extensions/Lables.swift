//
//  Lables.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation

final class Texts {
    enum Common {
        static let title = "Vremeni"
    }
    
    enum Placeholder {
        static let title = "No Results"
        static let discription = "for"
    }
    
    enum ProgressBar {
        static let progress = "Progress"
        static let completed = "Completed"
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
        static let searchItems = "Search items"
        static let filterItems = "Filter items"
        static let placeholder = "Click on the '+' button to add an Item"

        static let addItem = "Add"
        static let addToMachine = "Add to Machine"
        static let research = "Research"
        
        static let status = "Status"
        static let available = "Available"
        static let locked = "Locked"
        
        static let placeholderTitle = "No available Items"
        static let placeholderSubtitle = "Unlock some Items or restore from Archive"
        static let placeholderTitleLocked = "Congratulations!"
        static let placeholderSubtitleLocked = "You have unlocked all Items"
        
        enum Rule {
            static let title = "Rule"
            static let section = "Research Conditions (Mock)"
            static let unlock = "Unlock"
            static let soon = "Coming soon!"
            static let working = "Working on this 23/7 for a Great Party."
            static let ok = "Give a bowl of rice"
        }
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
        static let receiveRules = "Research rule"
        static let applicationRules = "Application rules"
        static let null = "Null"
    }
    
    enum MachinePage {
        static let title = "Machine"
        static let placeholderTitle = "No queue"
        static let placeholderSubtitle = "Add some Items from the Fair"
        
        static let workshop = "Workshop"
        static let emptyTitle = "Add an Item"
        static let queue = "Queue"
        
        static let upgrade = "Upgrade"
        static let purchase = "Purchase"
        
        static let targetTime = "Target time"
        static let potentialTime = "Potential target"
        static let reward = "Reward"
        static let pause = "Pause"
        static let start = "Start"
        static let continueProgress = "Continue"
    }
    
    enum InventoryPage {
        static let title = "Inventory"
        static let placeholderTitle = "No Inventory"
        static let placeholderSubtitle = "Get some Items from Fair via Machine"
        
        static let filter = "Filter"
        static let valuation = "Valuation"
    }
    
    enum ProfilePage {
        static let title = "Profile"
        static let user = "User"
        static let error = "Error"
        
        static let accept = "Accept"
        static let cancel = "Cancel"
        
        static let profile = "Profile"
        static let username = "Username"
        static let balance = "Balance"
        
        static let stats = "Stats"
        static let charts = "Charts"
        static let count = "Count"
        static let unlocked = "Unlocked"
        static let total = "Total"
        
        static let content = "Content"
        static let archive = "Archive"
        static let reset = "Reset"
        static let resetContent = "Do you want to start over? Purchases made with real currency will remain active."
        static let resetButton = "Reset progress"
        
        static let app = "Application"
        static let settings = "Settings"
        
        enum Stats {
            static let title = "Stats"
            static let placeholderTitle = "No Stats"
            static let placeholderDesc = "Get some items from Fair via Machine"
            
            static let bar = "Bar"
            static let count = "Count"
            static let category = "Category"
            static let type = "Chart type"
            
            static let progress = "Progress"
            static let balance = "Balance"
            static let valuation = "Valuation is"
            static let rarities = "Rarities"
            
            static let unlocked = "Unlocked"
            static let of = "of"
            static let value = "Value"
        }
        
        enum Archive {
            static let title = "Archive"
            static let placeholderTitle = "No archive"
            static let placeholderSubtitle = "Archived Items from the Fair will be here"
            
            static let valuation = "Valuation"
            static let restore = "Restore"
        }
        
        enum About {
            static let title = "About"
            static let version = "Version"
            static let release = "release"
            static let director = "Director"
            static let developer = "Developer"
            static let designer = "Designer"
            static let contact = "Contact"
            static let team = "Team"
            static let father = "Mikhail T."
            static let me = "Roman T."
            static let pups = "Artyom T."
            static let email = "Email"
            static let emailContent = "vremeni@icloud.com"
            
            static let directorLink = "https://t.me/Vremeni34"
            static let developLink = "https://www.linkedin.com/in/voityvit/"
            static let designerLink = "https://t.me/ArtyomTver"
        }
    }
    
    enum Banner {
        static let added = "Added to Machine."
        static let archived = "Moved to Archive."
        static let ready = "is ready."
        static let reset = "Progress has been reset."
    }
    
    enum TotalPrice {
        static let total = "Total"
    }
}

extension Notification.Name {
    static let resetProgressNotification = Notification.Name("resetProgressNotification")
    static let startProgressNotification = Notification.Name("startProgressNotification")
    static let inventoryUpdateNotification = Notification.Name("inventoryUpdateNotification")
}
