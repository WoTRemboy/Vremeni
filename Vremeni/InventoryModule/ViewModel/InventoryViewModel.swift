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
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        internal func updateOnAppear() {
            fetchData()
        }
        
        internal func addSamples() {
            let items = [ConsumableItem.itemMockConfig(name: "One Minute",
                                                       description: "One minute is a whole 60 seconds!",
                                                       price: 1,
                                                       ready: true),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       rarity: .uncommon,
                                                       ready: true),
                         
                         ConsumableItem.itemMockConfig(name: "Five Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 5,
                                                       rarity: .epic,
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
            } catch {
                print("Fetch failed")
            }
        }

    }
}
