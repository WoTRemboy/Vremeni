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
        
        private(set) var profile = Profile.configMockProfile()
        private(set) var items = [ConsumableItem]()
        private(set) var unfilteredItems = [ConsumableItem]()
        private(set) var statsItems = [ConsumableItem]()
        
        internal var rarityFilter: Rarity {
            didSet {
                fetchData()
            }
        }
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            self.rarityFilter = .all
        }
        
        internal func updateOnAppear() {
            fetchStatsData()
            fetchProfileData()
            fetchData()
        }
        
        internal func filterItems(for rarity: Rarity) -> [ConsumableItem] {
            unfilteredItems.filter({ $0.rarity == rarity })
        }
        
        internal func progressItemsCount() -> String {
            let inventoryItems = Float(unfilteredItems.count)
            let statsItems = Float(statsItems.count)
            guard statsItems > 0 else { return "0%" }
            
            let percent = Int(inventoryItems / statsItems * 100)
            return "\(percent)%"
        }
        
        internal func rarityItemsCount(for rarity: Rarity) -> String {
            let inventoryItems = items.filter({ $0.rarity == rarity }).count
            let allItems = statsItems.filter({ $0.rarity == rarity }).count
            return "\(inventoryItems) / \(allItems)"
        }
        
        internal func rarityItemsPercent(for rarity: Rarity) -> String {
            let inventoryItems = Float(items.filter({ $0.rarity == rarity }).count)
            let statsItems = Float(statsItems.filter({ $0.rarity == rarity }).count)
            guard statsItems > 0 else { return "0%" }
            
            let percent = Int(inventoryItems / statsItems * 100)
            return "\(percent)%"
        }
        
        internal func valCalculation(for item: ConsumableItem) -> String {
            String(Int(item.price) * item.count)
        }
        
        internal func addSamples() {
            let items = [ConsumableItem.itemMockConfig(name: "One Minute",
                                                       description: "One minute is a whole 60 seconds!",
                                                       price: 1,
                                                       profile: profile,
                                                       ready: true),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       rarity: .common,
                                                       profile: profile,
                                                       ready: true),
                         
                         ConsumableItem.itemMockConfig(name: "Five Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 5,
                                                       rarity: .common,
                                                       profile: profile,
                                                       ready: true),
                         ConsumableItem.itemMockConfig(name: "Seven Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 7,
                                                       rarity: .uncommon,
                                                       profile: profile,
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
        
        private func fetchStatsData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>()
                statsItems = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
        
        private func fetchProfileData() {
            do {
                // Gets profile from SwiftData DB
                let descriptor = FetchDescriptor<Profile>()
                profile = try modelContext.fetch(descriptor).first ?? Profile.configMockProfile()
            } catch {
                print("Fetch failed")
            }
        }

    }
}
