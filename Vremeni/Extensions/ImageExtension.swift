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
    
    enum OnboardingPage {
        static let first = Image("OnboardingFirst")
        static let second = Image("OnboardingSecond")
        static let third = Image("OnboardingThird")
        static let fourth = Image("OnboardingFourth")
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
        static let final = Image("RarityFinal")
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


extension UIImage {
    static let placeholder = UIImage(named: "Placeholder1to1")
    
    enum Content {
        enum Common {
            static let oneMinute = UIImage(named: "OneMinuteCommon")
            static let twoMinutes = UIImage(named: "TwoMinutesCommon")
            static let threeMinutes = UIImage(named: "ThreeMinutesCommon")
            static let fourMinutes = UIImage(named: "FourMinutesCommon")
            static let fiveMinutes = UIImage(named: "FiveMinutesCommon")
            static let sixMinutes = UIImage(named: "SixMinutesCommon")
            static let sevenMinutes = UIImage(named: "SevenMinutesCommon")
            static let eightMinutes = UIImage(named: "EightMinutesCommon")
            static let nineMinutes = UIImage(named: "NineMinutesCommon")
            static let tenMinutes = UIImage(named: "TenMinutesCommon")
        }
        
        enum Uncommon {
            static let twelveMinutes = UIImage(named: "12MinutesUncommon")
            static let twentyMinutes = UIImage(named: "20MinutesUncommon")
            static let thirtyFiveMinutes = UIImage(named: "35MinutesUncommon")
            static let oneHourFifteenMinutes = UIImage(named: "115MinutesUncommon")
            static let twoHoursThirtyMinutes = UIImage(named: "230MinutesUncommon")
            static let fourHours = UIImage(named: "400MinutesUncommon")
            static let tenHours = UIImage(named: "1000MinutesUncommon")
        }
        
        enum Rare {
            static let fourteenMinutes = UIImage(named: "14MinutesRare")
            static let thirtyFourMinutes = UIImage(named: "34MinutesRare")
            static let oneHourNinteenMinutes = UIImage(named: "119MinutesRare")
            static let twoHoursFourtyNineMinutes = UIImage(named: "249MinutesRare")
        }
        
        enum Epic {
            static let fifteenMinutes = UIImage(named: "15MinutesEpic")
            static let thirtyMinutes = UIImage(named: "30MinutesEpic")
            static let fourtyFiveMinutes = UIImage(named: "45MinutesEpic")
            static let oneHour = UIImage(named: "100MinutesEpic")
        }
        
        enum Legendary {
            static let seventeenMinutes = UIImage(named: "17MinutesLegendary")
            static let thirtyTwoMinutes = UIImage(named: "32MinutesLegendary")
            static let fiftyTwoMinutes = UIImage(named: "52MinutesLegendary")
            static let oneHourTwentyTwoMinutes = UIImage(named: "122MinutesLegendary")
        }
        
        enum Mythic {
            static let ninteenMinutes = UIImage(named: "19MinutesMythic")
            static let twentyNineMinutes = UIImage(named: "29MinutesMythic")
            static let thirtyNineMinutes = UIImage(named: "39MinutesMythic")
            static let fourtyNineMinutes = UIImage(named: "49MinutesMythic")
        }
        
        enum Exotic {
            static let oneHourThirtyMinutes = UIImage(named: "130MinutesExotic")
            static let threeHours = UIImage(named: "300MinutesExotic")
            static let fourHoursThirtyMinutes = UIImage(named: "430MinutesExotic")
            static let sixHours = UIImage(named: "600MinutesExotic")
        }
        
        enum Final {
            static let twentyFourHours = UIImage(named: "2400MinutesFinal")
        }
    }
}
