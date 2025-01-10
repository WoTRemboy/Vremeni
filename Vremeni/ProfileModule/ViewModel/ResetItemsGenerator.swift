//
//  ResetItemsGenerator.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 1/10/25.
//

import UIKit

extension ProfileView.ProfileViewModel {
    internal func itemGenerator() -> [ConsumableItem] {
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

        let items = [oneMinute, twoMinutes, threeMinutes, fourMinutes, fiveMinutes, sixMinutes, sevenMinutes, eightMinutes, nineMinutes, tenMinutes]
        return items
    }
}
