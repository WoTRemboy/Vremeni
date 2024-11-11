//
//  ShopViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftData
import SwiftUI

// MARK: - View Extension is a way to make SwiftData compatible with MVVM

extension ShopView {
    
    // Observable macro needs to be able to perform a SwiftData fetch when it loads
    @Observable
    final class ShopViewModel {
        
        // MARK: - Properties
        
        private var modelContext: ModelContext
        private(set) var items = [ConsumableItem]()
        private(set) var allItems = [ConsumableItem]()
        private(set) var profile = Profile.configMockProfile()
        
        private(set) var currentSubType: SubscriptionType = .annual
        
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
            guard profile.balance >= Int(item.price) else { return }
            item.unlockItem()
            
            for requirement in item.requirement {
                let consItem = allItems.first(where: { $0.nameKey == requirement.key })
                consItem?.reduceCount(for: requirement.value)
            }
            profile.unlockItem(for: item.price)
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
        
        // MARK: - Research Setups
        
        // Setups content for ParameterRow content row (Research page)
        internal func researchContentSetup(for requirement: String) -> String {
            "\(Texts.ShopPage.Rule.inventory): \(inventoryItemCount(for: requirement))"
        }
        
        // Setups content for ParameterRow trailing row (Research page)
        internal func researchTrailingSetup(for requirement: String, of count: Int) -> String {
            "\(inventoryItemCount(for: requirement))/\(count)"
        }
        
        // Defines research type for item requirement (Research page)
        internal func researchTypeDefinition(for requirement: String, of count: Int) -> ResearchType {
            if inventoryItemCount(for: requirement) >= count {
                return .completed
            } else if ((allItems.first(where: { $0.nameKey == requirement })?.enabled) == false) {
                return .locked
            } else {
                return .less
            }
        }
        
        // Defines research type for price requirement (Research page)
        internal func researchTypeDefinition(for price: Float) -> ResearchType {
            if profile.balance >= Int(price) {
                return .completed
            } else {
                return .less
            }
        }
        
        // Checks that all conditions are met
        internal func unlockButtonAvailable(for item: ConsumableItem) -> Bool {
            // Items collection requirements check
            for requirement in item.requirement {
                guard researchTypeDefinition(for: requirement.key, of: requirement.value) == .completed else { return false }
            }
            // Coins requirement check
            guard researchTypeDefinition(for: item.price) == .completed else { return false }
            
            return true
        }
        
        // Configures research rule description for Details Page
        internal func ruleDesctiption(item: ConsumableItem) -> [String] {
            // For the first item (One Hours) there are no requirements
            guard !item.requirement.isEmpty else { return [Texts.ItemCreatePage.null] }
            
            var rule = [String]()
            let requirements = item.requirement.sorted { $0.value > $1.value }
            for requirement in requirements {
                // Setups requirement string
                let requirementName = NSLocalizedString(requirement.key, comment: String())
                let reqString = "\(requirementName) × \(requirement.value)"
                rule.append(reqString)
            }
            
            return rule
        }
        
        // Configures application rules description for Details Page
        internal func applicationDesctiption(item: ConsumableItem) -> [String] {
            // For the first item (One Hours) there are no requirements
            guard !item.applications.isEmpty else { return [Texts.ItemCreatePage.null] }
            
            var items = [String]()
            let applications = item.applications.sorted { $0.value < $1.value }
            for application in applications {
                // Setups application string
                let applicationName = NSLocalizedString(application.key, comment: String())
                let reqString = applicationName
                items.append(reqString)
            }
            
            return items
        }
        
        // MARK: - Premium Type selection method
        
        internal func changeSubType(to type: SubscriptionType) {
            withAnimation(.easeInOut(duration: 0.2)) {
                currentSubType = type
            }
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
        
        internal func inventoryItemCount(for name: String) -> Int {
            allItems.first(where: { $0.nameKey == name })?.count ?? -3
        }
        
        // MARK: - SwiftData management methods
        
        // Saves ConsumableItem to SwiftData DB
        internal func saveItem(_ created: ConsumableItem) {
            let item = ConsumableItem.itemMockConfig(nameKey: created.name,
                                                     descriptionKey: created.itemDescription,
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
        
        // MARK: - Load data method
        
        private func fetchData(filterReset: Bool = false) {
            do {
                // Gets items from SwiftData DB for current enable status
                let descriptor = FetchDescriptor<ConsumableItem>(sortBy: [SortDescriptor(\.price)])
                allItems = try modelContext.fetch(descriptor)
                items = allItems.filter { $0.enabled == enableStatus && !$0.archived }
                
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
            let profile = Profile(name: Texts.ProfilePage.user, balance: 0, premium: false, items: items)
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
        
        // MARK: - Mock data method
        
        internal func addSamples() {
            guard allItems.isEmpty else { return }
            let items = [
                ConsumableItem.itemMockConfig(nameKey: Content.Common.oneMinuteTitle,
                                              descriptionKey: Content.Common.oneMinuteDescription,
                                              price: 1,
                                              profile: profile,
                                              applications: [RuleItem.threeHours.rawValue : 3,
                                                             RuleItem.fiveHours.rawValue : 5,
                                                             RuleItem.sevenHours.rawValue : 7]
                                             ),
                         
                ConsumableItem.itemMockConfig(nameKey: Content.Common.threeMinutesTitle,
                                              descriptionKey: Content.Common.threeMinutesDescription,
                                              price: 3,
                                              rarity: .common,
                                              profile: profile,
                                              requirement: [RuleItem.oneHour.rawValue : 3],
                                              applications: [RuleItem.fiveHours.rawValue : 5,
                                                             RuleItem.tenHours.rawValue : 10],
                                              enabled: false),
                         
                ConsumableItem.itemMockConfig(nameKey: Content.Uncommon.fiveMinutesTitle,
                                              descriptionKey: Content.Uncommon.fiveMinutesDescription,
                                              price: 5,
                                              rarity: .uncommon,
                                              profile: profile,
                                              requirement: [RuleItem.oneHour.rawValue : 2, RuleItem.threeHours.rawValue : 1],
                                              applications: [RuleItem.sevenHours.rawValue : 7],
                                              enabled: false),
                
                ConsumableItem.itemMockConfig(nameKey: Content.Uncommon.sevenMinutesTitle,
                                              descriptionKey: Content.Uncommon.sevenMinutesDescription,
                                              price: 7,
                                              rarity: .uncommon,
                                              profile: profile,
                                              requirement: [RuleItem.fiveHours.rawValue : 1, RuleItem.oneHour.rawValue : 2],
                                              applications: [RuleItem.tenHours.rawValue : 10],
                                              enabled: false),
                
                ConsumableItem.itemMockConfig(nameKey: Content.Rare.tenMinutesTitle,
                                              descriptionKey: Content.Rare.tenMinutesDescription,
                                              price: 10,
                                              rarity: .rare,
                                              profile: profile,
                                              requirement: [RuleItem.sevenHours.rawValue : 1, RuleItem.threeHours.rawValue : 1],
                                              enabled: false)]
            for item in items {
                modelContext.insert(item)
            }
            fetchData()
        }
    }
}
