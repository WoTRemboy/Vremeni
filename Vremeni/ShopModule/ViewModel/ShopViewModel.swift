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
        private(set) var unfilteredItems = [ConsumableItem]()
        
        internal var rarityFilter: Rarity {
            didSet {
                fetchData()
            }
        }
        
        internal var enableStatus: Bool {
            didSet {
                fetchData(filterReset: true)
            }
        }
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            self.enableStatus = true
            self.rarityFilter = .all
            fetchData()
            addSamples()
        }
        
        internal func pickItem(item: ConsumableItem) {
            item.addToMachine()
            fetchData()
        }
        
        internal func unlockItem(item: ConsumableItem) {
            item.unlockItem()
            fetchData()
        }
        
        internal func findIndex(for item: ConsumableItem) -> Int {
            items.firstIndex(of: item) ?? -1
        }
        
        internal func saveItem(_ created: ConsumableItem) {
            let item = ConsumableItem.itemMockConfig(name: created.name, description: created.itemDescription, price: created.price, rarity: created.rarity, enabled: created.enabled)
            modelContext.insert(item)
            fetchData()
        }
        
        internal func deleteItem(item: ConsumableItem) {
            modelContext.delete(item)
            fetchData()
        }
        
        internal func filterItems(for rarity: Rarity) -> [ConsumableItem] {
            unfilteredItems.filter({ $0.rarity == rarity })
        }
        
        internal func changeRowItems(enabled: Bool) -> Int {
            enabled ? 2 : 1
        }
        
        internal func addSamples() {
            guard items.isEmpty else { return }
            let items = [ConsumableItem.itemMockConfig(name: "One Minute",
                                                       description: "One minute is a whole 60 seconds!",
                                                       price: 1),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       rarity: .common,
                                                       enabled: false),
                         
                         ConsumableItem.itemMockConfig(name: "Five Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 5,
                                                       rarity: .uncommon,
                                                       enabled: false),
                         ConsumableItem.itemMockConfig(name: "Seven Minutes",
                                                       description: "Seven minutes is a whole 420 seconds!",
                                                       price: 7,
                                                       rarity: .uncommon,
                                                       enabled: false),
                         ConsumableItem.itemMockConfig(name: "Ten Minutes",
                                                       description: "Ten minutes is a whole 600 seconds!",
                                                       price: 10,
                                                       rarity: .rare,
                                                       enabled: false)]
            for item in items {
                modelContext.insert(item)
            }
            fetchData()
        }
        
        private func fetchData(filterReset: Bool = false) {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { $0.enabled == enableStatus }, sortBy: [SortDescriptor(\.price)])
                items = try modelContext.fetch(descriptor)
                
                if rarityFilter != .all && !filterReset {
                    items = items.filter { $0.rarity == rarityFilter }
                } else {
                    unfilteredItems = items
                    
                    if rarityFilter != .all {
                        rarityFilter = .all
                    }
                }
            } catch {
                print("Fetch failed")
            }
        }
        
    }
}
