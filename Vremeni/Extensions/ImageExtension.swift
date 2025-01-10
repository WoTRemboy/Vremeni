//
//  ImageExtension.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI
import UIKit

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
            static let icon = Image("IconSelectPremium")
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
        static let stats = Image("StatsProfile")
        static let archive = Image("ArchiveProfile")
        static let reset = Image("ResetProfile")
        static let about = Image("AboutProfile")
        static let notifications = Image("NotificationsProfile")
        static let cloud = Image("CloudProfile")
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
    
    enum Content {
        enum Common {
            static let oneMinute = Image("OneMinuteCommon")
            static let twoMinutes = Image("TwoMinutesCommon")
            static let threeMinutes = Image("ThreeMinutesCommon")
            static let fourMinutes = Image("FourMinutesCommon")
            static let fiveMinutes = Image("FiveMinutesCommon")
            static let sixMinutes = Image("SixMinutesCommon")
            static let sevenMinutes = Image("SevenMinutesCommon")
            static let eightMinutes = Image("EightMinutesCommon")
            static let nineMinutes = Image("NineMinutesCommon")
            static let tenMinutes = Image("TenMinutesCommon")
        }
        
        enum Uncommon {
            static let twelveMinutes = Image("12MinutesUncommon")
            static let twentyMinutes = Image("20MinutesUncommon")
            static let thirtyFiveMinutes = Image("35MinutesUncommon")
            static let oneHourFifteenMinutes = Image("115MinutesUncommon")
            static let twoHoursThirtyMinutes = Image("230MinutesUncommon")
            static let fourHours = Image("400MinutesUncommon")
            static let tenHours = Image("1000MinutesUncommon")
        }
        
        enum Rare {
            static let fourteenMinutes = Image("14MinutesRare")
            static let thirtyFourMinutes = Image("34MinutesRare")
            static let oneHourNinteenMinutes = Image("119MinutesRare")
            static let twoHoursFourtyNineMinutes = Image("249MinutesRare")
        }
        
        enum Epic {
            static let fifteenMinutes = Image("15MinutesEpic")
            static let thirtyMinutes = Image("30MinutesEpic")
            static let fourtyFiveMinutes = Image("45MinutesEpic")
            static let oneHour = Image("100MinutesEpic")
        }
        
        enum Legendary {
            static let seventeenMinutes = Image("17MinutesLegendary")
            static let thirtyTwoMinutes = Image("32MinutesLegendary")
            static let fiftyTwoMinutes = Image("52MinutesLegendary")
            static let oneHourTwentyTwoMinutes = Image("122MinutesLegendary")
        }
        
        enum Mythic {
            static let ninteenMinutes = Image("19MinutesMythic")
            static let twentyNineMinutes = Image("29MinutesMythic")
            static let thirtyNineMinutes = Image("39MinutesMythic")
            static let fourtyNineMinutes = Image("49MinutesMythic")
        }
        
        enum Exotic {
            static let oneHourThirtyMinutes = Image("130MinutesExotic")
            static let threeHours = Image("300MinutesExotic")
            static let fourHoursThirtyMinutes = Image("430MinutesExotic")
            static let sixHours = Image("600MinutesExotic")
        }
    }
}


extension UIImage {
    static let placeholder = UIImage(named: "Placeholder1to1")
}
