//
//  ItemsGenerator.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 1/10/25.
//

import UIKit

extension ShopView.ShopViewModel {
    internal func itemGenerator() -> [ConsumableItem] {
        
        // MARK: - Common Tier
        
        let oneMinute = ConsumableItem.itemConfig(
            nameKey: Content.Common.oneMinuteTitle,
            descriptionKey: Content.Common.oneMinuteDescription,
            price: 1,
            image: UIImage.Content.Common.oneMinute?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            applications: [RuleItem.twoMinutes.nameKey : 2,
                           RuleItem.threeMinutes.nameKey : 3]
        )
        
        let twoMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.twoMinutesTitle,
            descriptionKey: Content.Common.twoMinutesDescription,
            price: 2,
            image: UIImage.Content.Common.twoMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: oneMinute, quantity: 2)],
            applications: [RuleItem.threeMinutes.nameKey : 3,
                           RuleItem.fourMinutes.nameKey : 4,
                           RuleItem.fiveMinutes.nameKey : 5],
            enabled: false
        )

        let threeMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.threeMinutesTitle,
            descriptionKey: Content.Common.threeMinutesDescription,
            price: 3,
            image: UIImage.Content.Common.threeMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: oneMinute, quantity: 1),
                           Requirement(item: twoMinutes, quantity: 1)],
            applications: [RuleItem.fiveMinutes.nameKey : 5,
                           RuleItem.sixMinutes.nameKey : 6,
                           RuleItem.sevenMinutes.nameKey : 7],
            enabled: false
        )
        
        let fourMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.fourMinutesTitle,
            descriptionKey: Content.Common.fourMinutesDescription,
            price: 4,
            image: UIImage.Content.Common.fourMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: twoMinutes, quantity: 2)],
            applications: [RuleItem.sevenMinutes.nameKey : 7,
                           RuleItem.eightMinutes.nameKey : 8,
                           RuleItem.nineMinutes.nameKey : 9],
            enabled: false
        )

        let fiveMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.fiveMinutesTitle,
            descriptionKey: Content.Common.fiveMinutesDescription,
            price: 5,
            image: UIImage.Content.Common.fiveMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: twoMinutes, quantity: 2),
                           Requirement(item: threeMinutes, quantity: 1)],
            applications: [RuleItem.nineMinutes.nameKey : 9,
                           RuleItem.tenMinutes.nameKey : 10],
            enabled: false
        )
        
        let sixMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.sixMinutesTitle,
            descriptionKey: Content.Common.sixMinutesDescription,
            price: 6,
            image: UIImage.Content.Common.sixMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: threeMinutes, quantity: 2)],
            applications: [:],
            enabled: false
        )

        let sevenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.sevenMinutesTitle,
            descriptionKey: Content.Common.sevenMinutesDescription,
            price: 7,
            image: UIImage.Content.Common.sevenMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: threeMinutes, quantity: 1),
                           Requirement(item: fourMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let eightMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.eightMinutesTitle,
            descriptionKey: Content.Common.eightMinutesDescription,
            price: 8,
            image: UIImage.Content.Common.eightMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: fourMinutes, quantity: 2)],
            applications: [:],
            enabled: false
        )
        
        let nineMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.nineMinutesTitle,
            descriptionKey: Content.Common.nineMinutesDescription,
            price: 9,
            image: UIImage.Content.Common.nineMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: fourMinutes, quantity: 1),
                           Requirement(item: fiveMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )

        let tenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Common.tenMinutesTitle,
            descriptionKey: Content.Common.tenMinutesDescription,
            price: 10,
            image: UIImage.Content.Common.tenMinutes?.pngData(),
            premium: false,
            rarity: .common,
            profile: profile,
            requirements: [Requirement(item: fiveMinutes, quantity: 2)],
            applications: [:],
            enabled: false
        )

        let commonItems = [oneMinute, twoMinutes, threeMinutes, fourMinutes, fiveMinutes, sixMinutes, sevenMinutes, eightMinutes, nineMinutes, tenMinutes]
        
        // MARK: - Uncommon Tier
        
        let twelveMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Uncommon.twelveMinutesTitle,
            descriptionKey: Content.Uncommon.twelveMinutesDescription,
            price: 12,
            image: UIImage.Content.Uncommon.twelveMinutes?.pngData(),
            premium: false,
            rarity: .uncommon,
            profile: profile,
            requirements: [Requirement(item: twoMinutes, quantity: 1),
                           Requirement(item: tenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let twentyMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Uncommon.twentyMinutesTitle,
            descriptionKey: Content.Uncommon.twentyMinutesDescription,
            price: 20,
            image: UIImage.Content.Uncommon.twentyMinutes?.pngData(),
            premium: false,
            rarity: .uncommon,
            profile: profile,
            requirements: [Requirement(item: eightMinutes, quantity: 1),
                           Requirement(item: twelveMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let thirtyFiveMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Uncommon.thirtyFiveMinutesTitle,
            descriptionKey: Content.Uncommon.thirtyFiveMinutesDescription,
            price: 35,
            image: UIImage.Content.Uncommon.thirtyFiveMinutes?.pngData(),
            premium: false,
            rarity: .uncommon,
            profile: profile,
            requirements: [Requirement(item: threeMinutes, quantity: 1),
                           Requirement(item: twentyMinutes, quantity: 1),
                           Requirement(item: twelveMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let oneHourFifteenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Uncommon.oneHourFifteenMinutesTitle,
            descriptionKey: Content.Uncommon.oneHourFifteenMinutesDescription,
            price: 75,
            image: UIImage.Content.Uncommon.oneHourFifteenMinutes?.pngData(),
            premium: false,
            rarity: .uncommon,
            profile: profile,
            requirements: [Requirement(item: sevenMinutes, quantity: 1),
                           Requirement(item: twelveMinutes, quantity: 1),
                           Requirement(item: twentyMinutes, quantity: 1),
                           Requirement(item: thirtyFiveMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let twoHoursThirtyMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Uncommon.twoHoursThirtyMinutesTitle,
            descriptionKey: Content.Uncommon.twoHoursThirtyMinutesDescription,
            price: 150,
            image: UIImage.Content.Uncommon.twoHoursThirtyMinutes?.pngData(),
            premium: false,
            rarity: .uncommon,
            profile: profile,
            requirements: [Requirement(item: oneHourFifteenMinutes, quantity: 2)],
            applications: [:],
            enabled: false
        )
        
        let fourHours = ConsumableItem.itemConfig(
            nameKey: Content.Uncommon.fourHoursTitle,
            descriptionKey: Content.Uncommon.fourHoursDescription,
            price: 240,
            image: UIImage.Content.Uncommon.fourHours?.pngData(),
            premium: false,
            rarity: .uncommon,
            profile: profile,
            requirements: [Requirement(item: threeMinutes, quantity: 1),
                           Requirement(item: twelveMinutes, quantity: 1),
                           Requirement(item: oneHourFifteenMinutes, quantity: 1),
                           Requirement(item: twoHoursThirtyMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let tenHours = ConsumableItem.itemConfig(
            nameKey: Content.Uncommon.tenHoursTitle,
            descriptionKey: Content.Uncommon.tenHoursDescription,
            price: 600,
            image: UIImage.Content.Uncommon.tenHours?.pngData(),
            premium: false,
            rarity: .uncommon,
            profile: profile,
            requirements: [Requirement(item: fiveMinutes, quantity: 1),
                           Requirement(item: twentyMinutes, quantity: 1),
                           Requirement(item: thirtyFiveMinutes, quantity: 1),
                           Requirement(item: twoHoursThirtyMinutes, quantity: 2),
                           Requirement(item: fourHours, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let uncommonItems = [twelveMinutes, twentyMinutes, thirtyFiveMinutes, oneHourFifteenMinutes, twoHoursThirtyMinutes, fourHours, tenHours]
        
        // MARK: - Rare Tier
        
        let fourteenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Rare.fourteenMinutesTitle,
            descriptionKey: Content.Rare.fourteenMinutesDescription,
            price: 14,
            image: UIImage.Content.Rare.fourteenMinutes?.pngData(),
            premium: false,
            rarity: .rare,
            profile: profile,
            requirements: [Requirement(item: fourMinutes, quantity: 1),
                           Requirement(item: tenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let thirtyFourMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Rare.thirtyFourMinutesTitle,
            descriptionKey: Content.Rare.thirtyFourMinutesDescription,
            price: 34,
            image: UIImage.Content.Rare.thirtyFourMinutes?.pngData(),
            premium: false,
            rarity: .rare,
            profile: profile,
            requirements: [Requirement(item: tenMinutes, quantity: 2),
                           Requirement(item: fourteenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let oneHourNinteenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Rare.oneHourNinteenMinutesTitle,
            descriptionKey: Content.Rare.oneHourNinteenMinutesDescription,
            price: 79,
            image: UIImage.Content.Rare.oneHourNinteenMinutes?.pngData(),
            premium: false,
            rarity: .rare,
            profile: profile,
            requirements: [Requirement(item: threeMinutes, quantity: 1),
                           Requirement(item: fourteenMinutes, quantity: 3),
                           Requirement(item: thirtyFourMinutes, quantity: 3)],
            applications: [:],
            enabled: false
        )
        
        let twoHoursFourtyNineMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Rare.twoHoursFourtyNineMinutesTitle,
            descriptionKey: Content.Rare.twoHoursFourtyNineMinutesDescription,
            price: 169,
            image: UIImage.Content.Rare.twoHoursFourtyNineMinutes?.pngData(),
            premium: false,
            rarity: .rare,
            profile: profile,
            requirements: [Requirement(item: fourteenMinutes, quantity: 4),
                           Requirement(item: thirtyFourMinutes, quantity: 1),
                           Requirement(item: oneHourNinteenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let rareItems = [fourteenMinutes, thirtyFourMinutes, oneHourNinteenMinutes, twoHoursFourtyNineMinutes]
        
        // MARK: - Epic Tier
        
        let fifteenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Epic.fifteenMinutesTitle,
            descriptionKey: Content.Epic.fifteenMinutesDescription,
            price: 15,
            image: UIImage.Content.Epic.fifteenMinutes?.pngData(),
            premium: false,
            rarity: .epic,
            profile: profile,
            requirements: [Requirement(item: fiveMinutes, quantity: 1),
                           Requirement(item: tenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let thirtyMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Epic.thirtyMinutesTitle,
            descriptionKey: Content.Epic.thirtyMinutesDescription,
            price: 30,
            image: UIImage.Content.Epic.thirtyMinutes?.pngData(),
            premium: false,
            rarity: .epic,
            profile: profile,
            requirements: [Requirement(item: fifteenMinutes, quantity: 2)],
            applications: [:],
            enabled: false
        )
        
        let fourtyFiveMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Epic.fourtyFiveMinutesTitle,
            descriptionKey: Content.Epic.fourtyFiveMinutesDescription,
            price: 45,
            image: UIImage.Content.Epic.fourtyFiveMinutes?.pngData(),
            premium: false,
            rarity: .epic,
            profile: profile,
            requirements: [Requirement(item: fifteenMinutes, quantity: 1),
                           Requirement(item: thirtyMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let oneHour = ConsumableItem.itemConfig(
            nameKey: Content.Epic.oneHourTitle,
            descriptionKey: Content.Epic.oneHourDescription,
            price: 60,
            image: UIImage.Content.Epic.oneHour?.pngData(),
            premium: false,
            rarity: .epic,
            profile: profile,
            requirements: [Requirement(item: fifteenMinutes, quantity: 1),
                           Requirement(item: fourtyFiveMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let epicItems = [fifteenMinutes, thirtyMinutes, fourtyFiveMinutes, oneHour]
        
        // MARK: - Legendary Tier
        
        let seventeenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Legendary.seventeenMinutesTitle,
            descriptionKey: Content.Legendary.seventeenMinutesDescription,
            price: 17,
            image: UIImage.Content.Legendary.seventeenMinutes?.pngData(),
            premium: false,
            rarity: .legendary,
            profile: profile,
            requirements: [Requirement(item: sevenMinutes, quantity: 1),
                           Requirement(item: tenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let thirtyTwoMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Legendary.thirtyTwoMinutesTitle,
            descriptionKey: Content.Legendary.thirtyTwoMinutesDescription,
            price: 32,
            image: UIImage.Content.Legendary.thirtyTwoMinutes?.pngData(),
            premium: false,
            rarity: .legendary,
            profile: profile,
            requirements: [Requirement(item: fiveMinutes, quantity: 1),
                           Requirement(item: tenMinutes, quantity: 1),
                           Requirement(item: seventeenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let fiftyTwoMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Legendary.fiftyTwoMinutesTitle,
            descriptionKey: Content.Legendary.fiftyTwoMinutesDescription,
            price: 52,
            image: UIImage.Content.Legendary.fiftyTwoMinutes?.pngData(),
            premium: false,
            rarity: .legendary,
            profile: profile,
            requirements: [Requirement(item: threeMinutes, quantity: 1),
                           Requirement(item: seventeenMinutes, quantity: 1),
                           Requirement(item: thirtyTwoMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let oneHourTwentyTwoMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Legendary.oneHourTwentyTwoMinutesTitle,
            descriptionKey: Content.Legendary.oneHourTwentyTwoMinutesDescription,
            price: 82,
            image: UIImage.Content.Legendary.oneHourTwentyTwoMinutes?.pngData(),
            premium: false,
            rarity: .legendary,
            profile: profile,
            requirements: [Requirement(item: threeMinutes, quantity: 1),
                           Requirement(item: tenMinutes, quantity: 1),
                           Requirement(item: seventeenMinutes, quantity: 1),
                           Requirement(item: fiftyTwoMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let legendaryItems = [seventeenMinutes, thirtyTwoMinutes, fiftyTwoMinutes, oneHourTwentyTwoMinutes]
        
        // MARK: - Mythic Tier
        
        let ninteenMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Mythic.ninteenMinutesTitle,
            descriptionKey: Content.Mythic.ninteenMinutesDescription,
            price: 19,
            image: UIImage.Content.Mythic.ninteenMinutes?.pngData(),
            premium: false,
            rarity: .mythic,
            profile: profile,
            requirements: [Requirement(item: nineMinutes, quantity: 1),
                           Requirement(item: tenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let twentyNineMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Mythic.twentyNineMinutesTitle,
            descriptionKey: Content.Mythic.twentyNineMinutesDescription,
            price: 29,
            image: UIImage.Content.Mythic.twentyNineMinutes?.pngData(),
            premium: false,
            rarity: .mythic,
            profile: profile,
            requirements: [Requirement(item: tenMinutes, quantity: 1),
                           Requirement(item: ninteenMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let thirtyNineMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Mythic.thirtyNineMinutesTitle,
            descriptionKey: Content.Mythic.thirtyNineMinutesDescription,
            price: 39,
            image: UIImage.Content.Mythic.thirtyNineMinutes?.pngData(),
            premium: false,
            rarity: .mythic,
            profile: profile,
            requirements: [Requirement(item: tenMinutes, quantity: 1),
                           Requirement(item: twentyNineMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let fourtyNineMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Mythic.fourtyNineMinutesTitle,
            descriptionKey: Content.Mythic.fourtyNineMinutesDescription,
            price: 49,
            image: UIImage.Content.Mythic.fourtyNineMinutes?.pngData(),
            premium: false,
            rarity: .mythic,
            profile: profile,
            requirements: [Requirement(item: tenMinutes, quantity: 1),
                           Requirement(item: thirtyNineMinutes, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let mythicItems = [ninteenMinutes, twentyNineMinutes, thirtyNineMinutes, fourtyNineMinutes]
        
        // MARK: - Exotic Tier
        
        let oneHourThirtyMinutes = ConsumableItem.itemConfig(
            nameKey: Content.Exotic.oneHourThirtyMinutesTitle,
            descriptionKey: Content.Exotic.oneHourThirtyMinutesDescription,
            price: 90,
            image: UIImage.Content.Exotic.oneHourThirtyMinutes?.pngData(),
            premium: false,
            rarity: .exotic,
            profile: profile,
            requirements: [Requirement(item: thirtyMinutes, quantity: 1),
                           Requirement(item: oneHour, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let threeHours = ConsumableItem.itemConfig(
            nameKey: Content.Exotic.threeHoursTitle,
            descriptionKey: Content.Exotic.threeHoursDescription,
            price: 180,
            image: UIImage.Content.Exotic.threeHours?.pngData(),
            premium: false,
            rarity: .exotic,
            profile: profile,
            requirements: [Requirement(item: oneHourThirtyMinutes, quantity: 2)],
            applications: [:],
            enabled: false
        )
        
        let fourHoursThirtyHours = ConsumableItem.itemConfig(
            nameKey: Content.Exotic.fourHoursThirtyMinutesTitle,
            descriptionKey: Content.Exotic.fourHoursThirtyMinutesDescription,
            price: 270,
            image: UIImage.Content.Exotic.fourHoursThirtyMinutes?.pngData(),
            premium: false,
            rarity: .exotic,
            profile: profile,
            requirements: [Requirement(item: oneHourThirtyMinutes, quantity: 1),
                           Requirement(item: threeHours, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let sixHours = ConsumableItem.itemConfig(
            nameKey: Content.Exotic.sixHoursTitle,
            descriptionKey: Content.Exotic.sixHoursDescription,
            price: 360,
            image: UIImage.Content.Exotic.sixHours?.pngData(),
            premium: false,
            rarity: .exotic,
            profile: profile,
            requirements: [Requirement(item: oneHourThirtyMinutes, quantity: 1),
                           Requirement(item: fourHoursThirtyHours, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let exoticItems = [oneHourThirtyMinutes, threeHours, fourHoursThirtyHours, sixHours]
        
        // MARK: - Final Tier
        
        let twentyFourHours = ConsumableItem.itemConfig(
            nameKey: Content.Final.twentyFourHoursTitle,
            descriptionKey: Content.Final.twentyFourHoursDescription,
            price: 1440,
            image: UIImage.Content.Final.twentyFourHours?.pngData(),
            premium: false,
            rarity: .final,
            profile: profile,
            requirements: [Requirement(item: tenMinutes, quantity: 1),
                           Requirement(item: fourtyNineMinutes, quantity: 1),
                           Requirement(item: oneHour, quantity: 1),
                           Requirement(item: oneHourTwentyTwoMinutes, quantity: 1),
                           Requirement(item: twoHoursFourtyNineMinutes, quantity: 1),
                           Requirement(item: sixHours, quantity: 1),
                           Requirement(item: tenHours, quantity: 1)],
            applications: [:],
            enabled: false
        )
        
        let finalItem = [twentyFourHours]
        
        let items = commonItems + uncommonItems + rareItems + epicItems + legendaryItems + mythicItems + exoticItems + finalItem
        
        return items
    }
}
