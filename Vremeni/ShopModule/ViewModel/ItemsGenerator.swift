//
//  ItemsGenerator.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 1/10/25.
//

extension ShopView.ShopViewModel {
    // MARK: - Mock data method
    internal func addSamples() {
        guard allItems.isEmpty else { return }
        let oneMinute = ConsumableItem.itemConfig(
            nameKey: Content.Common.oneMinuteTitle,
            descriptionKey: Content.Common.oneMinuteDescription,
            price: 1,
            premium: false,
            profile: profile,
            applications: [RuleItem.threeHours.rawValue : 3,
                           RuleItem.fiveHours.rawValue : 5,
                           RuleItem.sevenHours.rawValue : 7]
        )

        let threeMinutes = ConsumableItem.itemConfig(nameKey: Content.Common.threeMinutesTitle,
                                                     descriptionKey: Content.Common.threeMinutesDescription,
                                                     price: 3,
                                                     premium: false, rarity: .common,
                                                     profile: profile,
                                                     requirements: [Requirement(item: oneMinute, quantity: 3)],
                                                     applications: [RuleItem.fiveHours.rawValue : 5,
                                                                    RuleItem.tenHours.rawValue : 10],
                                                     enabled: false)

        let fiveMinutes = ConsumableItem.itemConfig(nameKey: Content.Uncommon.fiveMinutesTitle,
                                                    descriptionKey: Content.Uncommon.fiveMinutesDescription,
                                                    price: 5,
                                                    premium: false, rarity: .uncommon,
                                                    profile: profile,
                                                    requirements: [Requirement(item: oneMinute, quantity: 2), Requirement(item: threeMinutes, quantity: 1)],
                                                    applications: [RuleItem.sevenHours.rawValue : 7],
                                                    enabled: false)

        let sevenMinutes = ConsumableItem.itemConfig(nameKey: Content.Uncommon.sevenMinutesTitle,
                                                     descriptionKey: Content.Uncommon.sevenMinutesDescription,
                                                     price: 7,
                                                     premium: false, rarity: .uncommon,
                                                     profile: profile,
                                                     requirements: [Requirement(item: fiveMinutes, quantity: 1), Requirement(item: oneMinute, quantity: 2)],
                                                     applications: [RuleItem.tenHours.rawValue : 10],
                                                     enabled: false)

        let tenMinutes = ConsumableItem.itemConfig(nameKey: Content.Rare.tenMinutesTitle,
                                                   descriptionKey: Content.Rare.tenMinutesDescription,
                                                   price: 10,
                                                   premium: false, rarity: .rare,
                                                   profile: profile,
                                                   requirements: [Requirement(item: sevenMinutes, quantity: 1), Requirement(item: threeMinutes, quantity: 1)],
                                                   enabled: false)

        let items = [oneMinute, threeMinutes, fiveMinutes, sevenMinutes, tenMinutes]
        for item in items {
            modelContext.insert(item)
        }
        fetchData()
    }
}
