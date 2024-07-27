//
//  ShopViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import CoreData

final class ShopViewModel: ObservableObject {
    
    @Published private(set) var items = ConsumableItem.itemsMockConfig()
    
    internal func pickShopItem(context: NSManagedObjectContext, item: ConsumableItem) {
        let newItem = Item(context: context)
        newItem.id = UUID()
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = Int64(item.price)
        newItem.added = item.added
        newItem.started = Date.now
        newItem.target = item.target
        newItem.ready = item.ready
        
        try? context.save()
        
        items.removeAll { $0.id == item.id }
    }
    
}
