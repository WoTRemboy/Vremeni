//
//  InventoryViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 29.07.2024.
//

import Foundation
import SwiftUI
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
            NotificationCenter.default.addObserver(self, selector: #selector(handleDataUpdate), name: .inventoryUpdateNotification, object: nil)
        }
        
        @objc private func handleDataUpdate() {
            fetchStatsData()
            fetchData()
        }
        
        internal func updateOnAppear() {
            fetchStatsData()
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
            let items = [
                ConsumableItem.itemMockConfig(
                    nameKey: Content.Common.oneMinuteTitle,
                    descriptionKey: Content.Common.oneMinuteDescription,
                    price: 1,
                    profile: profile,
                    ready: true),
                         
                ConsumableItem.itemMockConfig(
                    nameKey: Content.Common.threeMinutesTitle,
                    descriptionKey: Content.Common.threeMinutesDescription,
                    price: 3,
                    rarity: .common,
                    profile: profile,
                    ready: true),
                         
                ConsumableItem.itemMockConfig(
                    nameKey: Content.Uncommon.fiveMinutesTitle,
                    descriptionKey: Content.Uncommon.fiveMinutesDescription,
                    price: 5,
                    rarity: .common,
                    profile: profile,
                    ready: true),
                
                ConsumableItem.itemMockConfig(
                    nameKey: Content.Uncommon.sevenMinutesTitle,
                    descriptionKey: Content.Uncommon.sevenMinutesDescription,
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
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { $0.ready && $0.count > 0 }, sortBy: [SortDescriptor(\.price)])
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
                print("ConsumableItem fetch for Inventory viewModel failed")
            }
        }
        
        private func fetchStatsData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>()
                statsItems = try modelContext.fetch(descriptor)
            } catch {
                print("All ConsumableItem fetch for Inventory viewModel failed")
            }
        }
    }
}
