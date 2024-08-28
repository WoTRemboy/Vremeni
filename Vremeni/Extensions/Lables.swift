//
//  Lables.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation

final class Texts {
    enum Common {
        static let title = NSLocalizedString("CommonTitle", comment: "Vremeni")
    }
    
    enum Placeholder {
        static let title = NSLocalizedString("PlaceholderTitle", comment: "No Results")
        static let discription = NSLocalizedString("PlaceholderDescription", comment: "for")
    }
    
    enum ProgressBar {
        static let progress = NSLocalizedString("ProgressBarTitle", comment: "Progress")
        static let completed = NSLocalizedString("ProgressBarCompleted", comment: "Completed")
    }
    
    enum Rarity {
        static let common = NSLocalizedString("RarityCommon", comment: "Common")
        static let uncommon = NSLocalizedString("RarityUncommon", comment: "Uncommon")
        static let rare = NSLocalizedString("RarityRare", comment: "Rare")
        static let epic = NSLocalizedString("RarityEpic", comment: "Epic")
        static let legendary = NSLocalizedString("RarityLegendary", comment: "Legendary")
        static let mythic = NSLocalizedString("RarityMythic", comment: "Mythic")
        static let transcendent = NSLocalizedString("RarityTranscendent", comment: "Transcendent")
        static let exotic = NSLocalizedString("RarityExotic", comment: "Exotic")
        static let all = NSLocalizedString("RarityAll", comment: "All")
    }
    
    enum ShopPage {
        static let title = NSLocalizedString("ShopPageTitle", comment: "Fair")
        static let searchItems = NSLocalizedString("ShopPageSearchItems", comment: "Search items")
        static let filterItems = "Filter items"

        static let addItem = NSLocalizedString("ShopPageAdd", comment: "Add")
        static let addToMachine = NSLocalizedString("ShopPageAddToMachine", comment: "Add to Machine")
        static let research = NSLocalizedString("ShopPageResearch", comment: "Research")
        
        static let status = NSLocalizedString("ShopPageStatus", comment: "Status")
        static let available = NSLocalizedString("ShopPageAvailable", comment: "Available")
        static let locked = NSLocalizedString("ShopPageLocked", comment: "Locked")
        
        static let placeholderTitle = NSLocalizedString("ShopPagePlaceholderTitle", comment: "No available Items")
        static let placeholderSubtitle = NSLocalizedString("ShopPagePlaceholderSubtitle", comment: "Unlock some Items or restore from Archive")
        static let placeholderTitleLocked = NSLocalizedString("ShopPagePlaceholderTitleLocked", comment: "Congratulations!")
        static let placeholderSubtitleLocked = NSLocalizedString("ShopPagePlaceholderSubtitleLocked", comment: "You have unlocked all Items")
        
        enum Rule {
            static let title = NSLocalizedString("ShopPageRuleTitle", comment: "Rule")
            static let section = NSLocalizedString("ShopPageRuleSection", comment: "Research Conditions (Mock)")
            static let inventory = NSLocalizedString("ShopPageRuleInventory", comment: "Inventory")
            static let coins = NSLocalizedString("ShopPageRuleCoins", comment: "Coins")
            static let unlock = NSLocalizedString("ShopPageRuleUnlock", comment: "Unlock")
            static let soon = NSLocalizedString("ShopPageRuleSoon", comment: "Coming soon!")
            static let working = NSLocalizedString("ShopPageRuleWorking", comment: "Working on this 23/7 for a Great Party.")
            static let ok = NSLocalizedString("ShopPageRuleOk", comment: "Give a bowl of rice")
        }
    }
    
    enum ItemCreatePage {
        static let title = NSLocalizedString("ItemCreatePageTitle", comment: "New Item")
        static let details = NSLocalizedString("ItemCreatePageDetails", comment: "Details")
        static let cancel = NSLocalizedString("ItemCreatePageCancel", comment: "Cancel")
        static let save = NSLocalizedString("ItemCreatePageSave", comment: "Save")
        
        static let price = NSLocalizedString("ItemCreatePagePrice", comment: "Price")
        static let total = NSLocalizedString("ItemCreatePageTotal", comment: "Total")
        
        static let general = NSLocalizedString("ItemCreatePageGeneral", comment: "General")
        static let name = NSLocalizedString("ItemCreatePageName", comment: "Name")
        static let description = NSLocalizedString("ItemCreatePageDescription", comment: "Description")
        static let rarity = NSLocalizedString("ItemCreatePageRarity", comment: "Rarity")
        static let valuation = NSLocalizedString("ItemCreatePageValuation", comment: "Valuation")
        static let turnover = NSLocalizedString("ItemCreatePageTurnover", comment: "Turnover (Soon)")
        static let receiveRules = NSLocalizedString("ItemCreatePageResearchRule", comment: "Research rule")
        static let applicationRules = NSLocalizedString("ItemCreatePageApplicationRule", comment: "Application rules")
        static let null = NSLocalizedString("ItemCreatePageNull", comment: "Null")
    }
    
    enum MachinePage {
        static let title = NSLocalizedString("MachinePageTitle", comment: "Machine")
        static let placeholderTitle = NSLocalizedString("MachinePagePlaceholderTitle", comment: "No queue")
        static let placeholderSubtitle = NSLocalizedString("MachinePagePlaceholderSubtitle", comment: "Add some Items from the Fair")
        
        static let workshop = NSLocalizedString("MachinePageWorkshop", comment: "Workshop")
        static let emptyTitle = NSLocalizedString("MachinePageAddItem", comment: "Add an Item")
        static let queue = NSLocalizedString("MachinePageQueue", comment: "Queue")
        
        static let upgrade = NSLocalizedString("MachinePageUpgrade", comment: "Upgrade")
        static let purchase = NSLocalizedString("MachinePagePurchase", comment: "Purchase")
        
        static let targetTime = NSLocalizedString("MachinePageTargetTime", comment: "Target time")
        static let potentialTime = NSLocalizedString("MachinePagePotentialTarget", comment: "Potential target")
        static let reward = NSLocalizedString("MachinePageReward", comment: "Reward")
        static let pause = NSLocalizedString("MachinePagePause", comment: "Pause")
        static let start = NSLocalizedString("MachinePageStart", comment: "Start")
        static let continueProgress = NSLocalizedString("MachinePageContinue", comment: "Continue")
    }
    
    enum InventoryPage {
        static let title = NSLocalizedString("InventoryPageTitle", comment: "Inventory")
        static let placeholderTitle = NSLocalizedString("InventoryPagePlaceholderTitle", comment: "No Inventory")
        static let placeholderSubtitle = NSLocalizedString("InventoryPagePlaceholderSubtitle", comment: "Get some Items from Fair via Machine")
        
        static let filter = "Filter"
        static let valuation = NSLocalizedString("InventoryPageValuation", comment: "Valuation")
    }
    
    enum ProfilePage {
        static let title = NSLocalizedString("ProfilePageTitle", comment: "Profile")
        static let user = "User"
        static let error = NSLocalizedString("ProfilePageError", comment: "Error")
        
        static let accept = NSLocalizedString("ProfilePageAccept", comment: "Accept")
        static let cancel = NSLocalizedString("ProfilePageCancel", comment: "Cancel")
        
        static let profile = NSLocalizedString("ProfilePageProfile", comment: "Profile")
        static let username = NSLocalizedString("ProfilePageUsername", comment: "Username")
        static let balance = NSLocalizedString("ProfilePageBalance", comment: "Balance")
        
        static let stats = NSLocalizedString("ProfilePageStats", comment: "Stats")
        static let charts = NSLocalizedString("ProfilePageCharts", comment: "Charts")
        static let count = NSLocalizedString("ProfilePageCount", comment: "Count")
        static let unlocked = NSLocalizedString("ProfilePageUnlocked", comment: "Unlocked")
        static let total = NSLocalizedString("ProfilePageTotal", comment: "Total")
        
        static let content = NSLocalizedString("ProfilePageContent", comment: "Content")
        static let archive = NSLocalizedString("ProfilePageArchive", comment: "Archive")
        static let reset = NSLocalizedString("ProfilePageReset", comment: "Reset")
        static let resetContent = NSLocalizedString("ProfilePageResetContent", comment: "Do you want to start over? Purchases made with real currency will remain active.")
        static let resetButton = NSLocalizedString("ProfilePageResetButton", comment: "Reset progress")
        
        static let app = NSLocalizedString("ProfilePageApplication", comment: "Application")
        static let notifications = NSLocalizedString("ProfilePageNotifications", comment: "Notifications")
        static let notificationsTitle = NSLocalizedString("ProfilePageNotificationsTitle", comment: "Notification Access Required")
        static let notificationsContent = NSLocalizedString("ProfilePageNotificationsContent", comment: "Please enable notifications in Settings.")
        
        static let appearance = NSLocalizedString("ProfilePageAppearance", comment: "Appearance")
        static let theme = NSLocalizedString("ProfilePageTheme", comment: "Theme")
        static let system = NSLocalizedString("ProfilePageSystem", comment: "System")
        static let light = NSLocalizedString("ProfilePageLight", comment: "Light")
        static let dark = NSLocalizedString("ProfilePageDark", comment: "Dark")
        static let done = NSLocalizedString("ProfilePageDone", comment: "Done")
        
        static let language = NSLocalizedString("ProfilePageLanguage", comment: "Language")
        static let languageDetails = NSLocalizedString("ProfilePageLanguageDetails", comment: "English")
        static let languageTitle = NSLocalizedString("ProfilePageLanguageTitle", comment: "Change language")
        static let languageContent = NSLocalizedString("ProfilePageLanguageContent", comment: "Select the language you want in Settings.")
        
        static let settings = NSLocalizedString("ProfilePageSettings", comment: "Settings")
        
        enum Stats {
            static let title = NSLocalizedString("ProfilePageStatsTitle", comment: "Stats")
            static let placeholderTitle = NSLocalizedString("ProfilePageStatsPlaceholderTitle", comment: "No Stats")
            static let placeholderDesc = NSLocalizedString("ProfilePageStatsPlaceholderDescription", comment: "Get some items from Fair via Machine")
            
            static let count = NSLocalizedString("ProfilePageStatsCount", comment: "Count")
            static let category = "Category"
            static let type = "Chart type"
            
            static let progress = NSLocalizedString("ProfilePageStatsProgress", comment: "Progress")
            static let balance = NSLocalizedString("ProfilePageStatsBalance", comment: "Balance")
            static let valuation = NSLocalizedString("ProfilePageStatsValuation", comment: "Valuation is")
            static let rarities = NSLocalizedString("ProfilePageStatsRarities", comment: "Rarities")
            
            static let unlocked = NSLocalizedString("ProfilePageStatsUnlocked", comment: "Unlocked")
            static let of = NSLocalizedString("ProfilePageStatsOf", comment: "of")
            static let value = "Value"
        }
        
        enum Archive {
            static let title = NSLocalizedString("ProfilePageArchiveTitle", comment: "Archive")
            static let placeholderTitle = NSLocalizedString("ProfilePageArchivePlaceholderTitle", comment: "No archive")
            static let placeholderSubtitle = NSLocalizedString("ProfilePageArchivePlaceholderSubtitle", comment: "Archived Items from the Fair will be here")
            
            static let valuation = NSLocalizedString("ProfilePageArchiveValuation", comment: "Valuation")
            static let restore = NSLocalizedString("ProfilePageArchiveRestore", comment: "Restore")
        }
        
        enum About {
            static let title = NSLocalizedString("ProfilePageAboutTitle", comment: "About")
            static let version = NSLocalizedString("ProfilePageAboutVersion", comment: "Version")
            static let release = "release"
            static let director = NSLocalizedString("ProfilePageAboutDirector", comment: "Director")
            static let developer = NSLocalizedString("ProfilePageAboutDeveloper", comment: "Developer")
            static let designer = NSLocalizedString("ProfilePageAboutDesigner", comment: "Designer")
            static let contact = NSLocalizedString("ProfilePageAboutContact", comment: "Contact")
            static let team = NSLocalizedString("ProfilePageAboutTeam", comment: "Team")
            static let father = NSLocalizedString("ProfilePageAboutFather", comment: "Mikhail T.")
            static let me = NSLocalizedString("ProfilePageAboutMe", comment: "Roman T.")
            static let pups = NSLocalizedString("ProfilePageAboutPups", comment: "Artyom T.")
            static let email = NSLocalizedString("ProfilePageAboutEmail", comment: "Email")
            static let emailContent = "vremeni@icloud.com"
            
            static let directorLink = "https://t.me/Vremeni34"
            static let developLink = "https://www.linkedin.com/in/voityvit/"
            static let designerLink = "https://t.me/ArtyomTver"
        }
    }
    
    enum Banner {
        static let added = NSLocalizedString("BannerAdded", comment: "Added to Machine.")
        static let archived = NSLocalizedString("BannerArchived", comment: "Moved to Archive.")
        static let ready = NSLocalizedString("BannerReady", comment: "is ready.")
        static let reset = NSLocalizedString("BannerReset", comment: "Progress has been reset.")
    }
    
    enum TotalPrice {
        static let total = NSLocalizedString("TotalPriceTitle", comment: "Total")
    }
    
    enum UserDefaults {
        static let notifications = "notificationsEnabled"
        static let theme = "userTheme"
    }
}

extension Notification.Name {
    static let resetProgressNotification = Notification.Name("resetProgressNotification")
    static let startProgressNotification = Notification.Name("startProgressNotification")
    static let inventoryUpdateNotification = Notification.Name("inventoryUpdateNotification")
    static let userNotificationUpdate = Notification.Name("userNotificationUpdate")
}
