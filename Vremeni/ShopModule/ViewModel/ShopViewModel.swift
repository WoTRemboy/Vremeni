//
//  ShopViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftData

// MARK: - View Extension is a way to make SwiftData compatible with MVVM

extension ShopView {
    
    // Observable macro needs to be able to perform a SwiftData fetch when it loads
    @Observable
    final class ShopViewModel {
        
        // MARK: - Properties
        
        private var modelContext: ModelContext
        private(set) var items = [ConsumableItem]()
        private(set) var profile = Profile.configMockProfile()
        
        // Array property for storing all current enable status items
        private(set) var unfilteredItems = [ConsumableItem]()
        
        // First appear toggle
        private var firstTime = true
        
        // Active rarity filter property with PO for data update
        internal var rarityFilter: Rarity {
            didSet {
                fetchData()
            }
        }
        
        // Active enable filter property with PO for data update
        internal var enableStatus: Bool {
            didSet {
                fetchData(filterReset: true)
            }
        }
        
        // MARK: - Initialization
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            self.enableStatus = true
            self.rarityFilter = .all
        }
        
        // MARK: - ConsumableItem status management methods
        
        // Adds ConsumableItem to Machine Module
        internal func pickItem(item: ConsumableItem) {
            item.addToMachine()
            fetchData()
        }
        
        // Transfers ConsumableItem from Locked status to Available
        internal func unlockItem(item: ConsumableItem) {
            item.unlockItem()
            fetchData()
        }
        
        // Updates item data when scroll view appears to detect unarchived items
        internal func updateOnAppear() {
            fetchData()
            fetchProfileData()
            addSamples()
            
            // Starts workshop timers when app loaded
            guard firstTime else { return }
            NotificationCenter.default.post(name: .startProgressNotification, object: nil)
            firstTime.toggle()
        }
        
        // MARK: - Calculation methods
        
        // Returns filtered elements by rarity
        internal func filterItems(for rarity: Rarity) -> [ConsumableItem] {
            unfilteredItems.filter({ $0.rarity == rarity })
        }
        
        // Returns the grid width depending on the enable filter value
        internal func changeRowItems(enabled: Bool) -> Int {
            enabled ? 2 : 1
        }
        
        // MARK: - SwiftData management methods
        
        // Saves ConsumableItem to SwiftData DB
        internal func saveItem(_ created: ConsumableItem) {
            let item = ConsumableItem.itemMockConfig(name: created.name,
                                                     description: created.itemDescription,
                                                     price: created.price,
                                                     rarity: created.rarity,
                                                     profile: profile,
                                                     enabled: created.enabled)
            modelContext.insert(item)
            fetchData()
        }
        
        // Deletes ConsumableItem from SwiftData DB
        internal func archiveItem(item: ConsumableItem) {
            item.archiveItem()
            fetchData()
        }
        
        // MARK: - Mock data method
        
        internal func addSamples() {
            guard items.isEmpty else { return }
            let items = [ConsumableItem.itemMockConfig(name: "One Minute",
                                                       description: "One minute is a whole 60 seconds!",
                                                       price: 1,
                                                       profile: profile),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       rarity: .common,
                                                       profile: profile,
                                                       enabled: false),
                         
                         ConsumableItem.itemMockConfig(name: "Five Minutes",
                                                       description: "Five minutes is a whole 300 seconds!",
                                                       price: 5,
                                                       rarity: .uncommon,
                                                       profile: profile,
                                                       enabled: false),
                         ConsumableItem.itemMockConfig(name: "Seven Minutes",
                                                       description: "Seven minutes is a whole 420 seconds!",
                                                       price: 7,
                                                       rarity: .uncommon,
                                                       profile: profile,
                                                       enabled: false),
                         ConsumableItem.itemMockConfig(name: "Ten Minutes",
                                                       description: "Ten minutes is a whole 600 seconds!",
                                                       price: 10,
                                                       rarity: .rare,
                                                       profile: profile,
                                                       enabled: false)]
            for item in items {
                modelContext.insert(item)
            }
            fetchData()
        }
        
        // MARK: - Load data method
        
        private func fetchData(filterReset: Bool = false) {
            do {
                // Gets items from SwiftData DB for current enable status
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { $0.enabled == enableStatus && !$0.archived }, sortBy: [SortDescriptor(\.price)])
                items = try modelContext.fetch(descriptor)
                
                // Check for .all tag selection or enable status changes (filterReset)
                if rarityFilter != .all && !filterReset {
                    // Filters items by rarity tag
                    items = items.filter { $0.rarity == rarityFilter }
                } else {
                    // Unfiltered items are current enable status items now
                    unfilteredItems = items
                    
                    // Changes tag to .all manually
                    if rarityFilter != .all {
                        rarityFilter = .all
                    }
                }
            } catch {
                print("ConsumableItem fetch for Shop viewModel failed")
            }
        }
        
        // MARK: - Profile data methods
        
        // First app launch case
        private func createProfile() {
            let profile = Profile(name: Texts.ProfilePage.user, balance: 10, items: items)
            modelContext.insert(profile)
            fetchProfileData()
        }
        
        private func fetchProfileData() {
            do {
                // Gets profile from SwiftData DB
                let descriptor = FetchDescriptor<Profile>()
                profile = try modelContext.fetch(descriptor).first ?? Profile.configMockProfile()
            } catch {
                print("Profile fetch for Shop viewModel failed")
            }
            
            guard profile == Profile.configMockProfile() else { return }
            createProfile()
        }
        
    }
}
