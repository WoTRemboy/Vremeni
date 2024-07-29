//
//  ShopViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftData

final class ShopViewModel: ObservableObject {
    
    @Published private(set) var items = ConsumableItem.itemsMockConfig()
    
    internal func pickItem(item: ConsumableItem, context: ModelContext) {
        item.setStartTime()
        context.insert(item)
        items.removeAll { $0.id == item.id }
    }
    
}
