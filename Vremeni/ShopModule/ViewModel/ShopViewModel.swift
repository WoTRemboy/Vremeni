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
        
        internal var enableStatus: Bool {
            didSet {
                fetchData()
            }
        }
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            self.enableStatus = true
            fetchData()
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
        
        internal func addSamples() {
            let items = [ConsumableItem.itemMockConfig(name: "One Minute",
                                                       description: "One minute is a whole 60 seconds!",
                                                       price: 1),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       rarity: .uncommon),
                         
                         ConsumableItem.itemMockConfig(name: "Five Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 5,
                                                       rarity: .rare,
                                                       enabled: false),
                         ConsumableItem.itemMockConfig(name: "Seven Minutes",
                                                       description: "Seven minutes is a whole 420 seconds!",
                                                       price: 7,
                                                       rarity: .rare)]
            for item in items {
                modelContext.insert(item)
            }
            fetchData()
        }
        
        private func fetchData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { !$0.inMachine && !$0.inProgress && !$0.ready }, sortBy: [SortDescriptor(\.price), SortDescriptor(\.added)])
                items = try modelContext.fetch(descriptor).filter { $0.enabled == enableStatus }
            } catch {
                print("Fetch failed")
            }
        }
        
    }
}
