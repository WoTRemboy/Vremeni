//
//  ImageExtension.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI

extension Image {
    enum SplashScreen {
        static let logo = Image("SplashLogo")
    }
    
    enum ShopPage {
        static let vCoin = Image("VCoin")
        static let filter = Image(systemName: "line.3.horizontal.decrease.circle")
        static let filledFilter = Image(systemName: "line.3.horizontal.decrease.circle.fill")
        static let plus = Image(systemName: "plus")
        static let premium = Image(systemName: "star")
        
        enum Premium {
            static let logo = Image("PremiumLogo")
            static let uncheck = Image(systemName: "circle")
            static let check = Image(systemName: "checkmark.circle.fill")
            static let content = Image("ExtendedContentPremium")
            static let machine = Image("MachineUpgradePremium")
            static let constructor = Image("ItemConstructorPremium")
            static let cloud = Image("CloudBackupPremium")
        }
        
        enum Research {
            static let check = Image(systemName: "checkmark.circle")
            static let locked = Image(systemName: "lock.circle")
            static let less = Image(systemName: "lessthan.circle")
        }
        
        enum CreatePage {
            static let addImage = Image(systemName: "plus.viewfinder")
            static let addRequirement = Image(systemName: "plus.circle.fill")
            static let reduceRequirement = Image(systemName: "minus.circle.fill")
        }
    }
    
    enum InventoryPage {
        static let count = Image(systemName: "x.circle.fill")
    }
    
    enum ProfilePage {
        static let person = Image("PersonProfile")
        static let balance = Image("BalanceProfile")
        static let archive = Image("ArchiveProfile")
        static let reset = Image("ResetProfile")
        static let about = Image("AboutProfile")
        static let notifications = Image("NotificationsProfile")
        static let appearance = Image("AppearanceProfile")
        static let language = Image("LanguageProfile")
        static let settings = Image("SettingsProfile")
        
        enum About {
            static let appIcon = Image("AboutIcon")
            static let crown = Image("CrownAbout")
            static let develop = Image("DevelopAbout")
            static let graphic = Image("GraphicAbout")
            static let email = Image("EmailAbout")
        }
    }
    
    enum Banner {
        static let added = Image("AddedBanner")
        static let archived = Image("ArchivedBanner")
        static let ready = Image("ReadyBanner")
        static let reset = Image("ResetBanner")
        static let unlocked = Image("UnlockedBanner")
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
        static let search = Image(systemName: "magnifyingglass")
        static let locked = Image(systemName: "fireworks")
        static let unlocked = Image(systemName: "lock.open")
        static let machine = Image(systemName: "clock.arrow.2.circlepath")
        static let inventory = Image(systemName: "rectangle.portrait.on.rectangle.portrait")
        static let archive = Image(systemName: "archivebox")
        static let stats = Image(systemName: "chart.xyaxis.line")
    }
}
