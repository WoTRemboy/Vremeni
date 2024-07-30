//
//  ShopViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftData

extension ShopView {
    
    @Observable
    final class ShopViewModel {
        private var modelContext: ModelContext
        private(set) var items = [ConsumableItem]()
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
                
        internal func pickItem(item: ConsumableItem) {
            item.setMachineTime()
            item.progressToggle()
            fetchData()
        }
        
        internal func findIndex(for item: ConsumableItem) -> Int {
            items.firstIndex(of: item) ?? -1
        }
        
        internal func saveItem(_ created: ConsumableItem) {
            let item = ConsumableItem.itemMockConfig(name: created.name, price: created.price, rarity: created.rarity)
            modelContext.insert(item)
            fetchData()
        }
        
        internal func deleteItem(item: ConsumableItem) {
            modelContext.delete(item)
            fetchData()
        }
        
        internal func addSamples() {
            let items = [ConsumableItem.itemMockConfig(name: "One Minute", price: 1),
                         ConsumableItem.itemMockConfig(name: "Three Minutes", price: 3, rarity: .uncommon),
                         ConsumableItem.itemMockConfig(name: "Five Minutes", price: 5, rarity: .rare)]
            for item in items {
                modelContext.insert(item)
            }
            fetchData()
        }
        
        private func fetchData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { !$0.inProgress && !$0.ready }, sortBy: [SortDescriptor(\.price), SortDescriptor(\.added)])
                items = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
        
    }
}
