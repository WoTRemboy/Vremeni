//
//  RuleModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/9/24.
//

import Foundation
import SwiftData

// MARK: - Rule Model

final class Rule: Identifiable {
    var id = UUID()
    var price: Float
    var requirement: [String: Int]
    var result: ConsumableItem
    
    init(id: UUID = UUID(), price: Float, requirement: [String: Int], result: ConsumableItem) {
        self.id = id
        self.price = price
        self.requirement = requirement
        self.result = result
    }
}

// MARK: - Rule Methods

extension Rule {
    static func mockRule() -> Rule {
        let price: Float = 5
        
        var requirement = [String: Int]()
        let one = ConsumableItem.itemConfig(nameKey: Content.Common.oneMinuteTitle, price: 1, profile: Profile.configMockProfile())
        let two = ConsumableItem.itemConfig(nameKey: Content.Common.threeMinutesTitle, price: 2, profile: Profile.configMockProfile())
        
        requirement[one.nameKey] = 1
        requirement[two.nameKey] = 2
        
        let result = ConsumableItem.itemConfig(nameKey: Content.Common.fiveMinutesTitle, price: 5, profile: Profile.configMockProfile())
        
        return Rule(price: price, requirement: requirement, result: result)
    }
    
    static internal func config(requirement: [String: Int], result: ConsumableItem) -> Rule {
        Rule(price: result.price,
             requirement: requirement,
             result: result)
    }
}


enum RuleItem {
    case oneMinute
    case twoMinutes
    case threeMinutes
    case fourMinutes
    case fiveMinutes
    case sixMinutes
    case sevenMinutes
    case eightMinutes
    case nineMinutes
    case tenMinutes
    
    internal var nameKey: String {
        switch self {
        case .oneMinute:
            Content.Common.oneMinuteTitle
        case .twoMinutes:
            Content.Common.twoMinutesTitle
        case .threeMinutes:
            Content.Common.threeMinutesTitle
        case .fourMinutes:
            Content.Common.fourMinutesTitle
        case .fiveMinutes:
            Content.Common.fiveMinutesTitle
        case .sixMinutes:
            Content.Common.sixMinutesTitle
        case .sevenMinutes:
            Content.Common.sevenMinutesTitle
        case .eightMinutes:
            Content.Common.eightMinutesTitle
        case .nineMinutes:
            Content.Common.nineMinutesTitle
        case .tenMinutes:
            Content.Common.tenMinutesTitle
        }
    }
}
