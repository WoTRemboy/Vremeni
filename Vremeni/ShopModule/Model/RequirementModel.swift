//
//  RequirementModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/30/24.
//

import Foundation
import SwiftData

@Model
final class Requirement: Identifiable {
    var id = UUID()
    @Relationship var item: ConsumableItem
    var quantity: Int

    init(item: ConsumableItem, quantity: Int) {
        self.item = item
        self.quantity = quantity
    }
}

extension ConsumableItem {
    internal func addRequirement(item: ConsumableItem, quantity: Int = 1) {
        guard let index = requirements.firstIndex(where: { $0.item == item }) else {
            let newRequirement = Requirement(item: item, quantity: quantity)
            requirements.append(newRequirement)
            return
        }
        requirements[index].quantity += 1
    }

    internal func reduceRequirement(requirement: Requirement) {
        guard let index = requirements.firstIndex(where: { $0 == requirement }) else {
            return
        }
        
        if requirement.quantity > 1 {
            requirements[index].quantity -= 1
        } else {
            requirements.remove(at: index)
        }
    }

    internal func removeRequirement(at offsets: IndexSet) {
        requirements.remove(atOffsets: offsets)
    }
}
