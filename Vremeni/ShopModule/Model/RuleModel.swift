//
//  RuleModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/9/24.
//

import Foundation

// MARK: - Rule Model

final class Rule: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var price: Float
    var requirement: Set<ConsumableItem>
    var result: ConsumableItem
    
    init(id: UUID = UUID(), name: String, description: String, price: Float, requirement: Set<ConsumableItem>, result: ConsumableItem) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.requirement = requirement
        self.result = result
    }
}

// MARK: - Rule Methods

extension Rule {
    internal var mockRule: Rule {
        let name = "Perfect score"
        let description = "The aspiration of any adequate person"
        let price: Float = 5
        
        var requirement = Set<ConsumableItem>()
        let one = ConsumableItem.itemMockConfig(nameKey: Content.Common.oneMinuteTitle, price: 1, profile: Profile.configMockProfile())
        let two = ConsumableItem.itemMockConfig(nameKey: Content.Common.threeMinutesTitle, price: 2, profile: Profile.configMockProfile())
        requirement.insert(one)
        requirement.insert(two)
        requirement.insert(two)
        
        let result = ConsumableItem.itemMockConfig(nameKey: Content.Uncommon.fiveMinutesTitle, price: 5, profile: Profile.configMockProfile())
        
        return Rule(name: name, description: description, price: price, requirement: requirement, result: result)
    }
}
