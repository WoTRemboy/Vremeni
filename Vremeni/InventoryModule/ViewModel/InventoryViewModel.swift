//
//  InventoryViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 29.07.2024.
//

import Foundation
import SwiftData

extension InventoryView {
    
    @Observable
    final class InventoryViewModel {
        private let modelContext: ModelContext
        
        private(set) var items = [ConsumableItem]()
        private(set) var unfilteredItems = [ConsumableItem]()
        
        internal var rarityFilter: Rarity {
            didSet {
                fetchData()
            }
        }
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            self.rarityFilter = .all
            fetchData()
        }
        
        internal func updateOnAppear() {
            fetchData()
        }
        
        internal func filterItems(for rarity: Rarity) -> [ConsumableItem] {
            unfilteredItems.filter({ $0.rarity == rarity })
        }
        
        internal func addSamples() {
            let items = [ConsumableItem.itemMockConfig(name: "One Minute",
                                                       description: "One minute is a whole 60 seconds!",
                                                       price: 1,
                                                       ready: true),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       rarity: .common,
                                                       ready: true),
                         
                         ConsumableItem.itemMockConfig(name: "Five Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 5,
                                                       rarity: .common,
                                                       ready: true),
                         ConsumableItem.itemMockConfig(name: "Seven Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 7,
                                                       rarity: .uncommon,
                                                       ready: true)]
            for item in items {
                modelContext.insert(item)
            }
            fetchData()
        }
        
        private func fetchData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { $0.ready }, sortBy: [SortDescriptor(\.price)])
                items = try modelContext.fetch(descriptor)
                
                if rarityFilter != .all {
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
