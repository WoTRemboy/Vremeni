//
//  ProfileViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import Foundation
import SwiftData
import SwiftUI

extension ProfileView {
    
    @Observable
    final class ProfileViewModel {
        private let modelContext: ModelContext
        
        private(set) var profile = Profile.configMockProfile()
        private(set) var version: String = String()
        
        private var items = [ConsumableItem]()
        private var unlockedItems = [ConsumableItem]()
        private var readyItems = [ConsumableItem]()
        private(set) var archivedItems = [ConsumableItem]()
        private(set) var actualRarities = [Rarity]()
        
        internal var itemsCount: Int {
            items.count
        }
        
        internal var rariries: [Rarity] {
            Rarity.allCases
        }
        
        internal var raritiesCount: Int {
            Rarity.allCases.count
        }
        
        internal var inventoryRarities: [Rarity] {
            actualRarities.filter { inventoryRarityCount(for: $0) > 0 }
        }
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        
        internal func updateOnAppear() {
            fetchProfileData()
            fetchItemsData()
            fetchArchivedItemsData()
        }
        
        internal func updateItemsOnAppear() {
            fetchArchivedItemsData()
        }
        
        internal func updateStatsOnAppear() {
            fetchItemsData()
            fetchActualRariries()
        }
        
        internal func rarityCount(for rarity: Rarity, all: Bool = false) -> Int {
            guard rarity != .all else { return unlockedItems.count }
            if all {
                return items.filter({ $0.rarity == rarity }).count
            } else {
                return unlockedItems.filter({ $0.rarity == rarity }).count
            }
        }
        
        internal func rarityPercent(for rarity: Rarity) -> Int {
            let allItems = Float(items.filter({ $0.rarity == rarity }).count)
            let unlockedItems = Float(unlockedItems.filter({ $0.rarity == rarity }).count)
            guard unlockedItems > 0 else { return 0 }
            return Int(unlockedItems / allItems * 100)
        }
        
        internal func valuationPercent(for rarity: Rarity) -> Int {
            guard profile.balance > 0 else { return 0 }
            let rarityItems = readyItems.filter { $0.rarity == rarity }
            let valuation = rarityItems.reduce(0) { $0 + (Int($1.price) * $1.count) }
            return Int(Float(valuation) / Float(profile.balance) * 100)
        }
        
        internal func inventoryRarityCount(for rarity: Rarity) -> Int {
            let rarityItems = readyItems.filter { $0.rarity == rarity }
            return rarityItems.reduce(0) { $0 + $1.count }
        }
        
        internal func updateVersionOnAppear() {
            versionDetect()
        }
        
        internal func changeNickname(to name: String) {
            profile.changeName(to: name)
            fetchProfileData()
        }
        
        internal func resetProgress() {
            do {
                let consumableItems = try modelContext.fetch(FetchDescriptor<ConsumableItem>())
                for item in consumableItems {
                    modelContext.delete(item)
                }
            } catch {
                print("Failed to delete ConsumableItem")
            }
            
            do {
                let machineItems = try modelContext.fetch(FetchDescriptor<MachineItem>())
                for item in machineItems {
                    modelContext.delete(item)
                }
                NotificationCenter.default.post(name: .resetProgressNotification, object: nil)
            } catch {
                print("Failed to delete MachineItem")
            }
            
            do {
                try modelContext.save()
            } catch {
                print("Failed to save context after reset")
            }
            
            profile.resetBalance()
            addSamples()
        }
        
        internal func unarchiveItem(item: ConsumableItem) {
            item.archiveItem()
            fetchArchivedItemsData()
        }
        
        internal func versionDetect() {
            if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
               let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                version = "\(appVersion) \(Texts.ProfilePage.About.release) \(buildVersion)"
            }
        }
        
        internal func addSamples() {
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
            fetchItemsData()
            fetchActualRariries()
            fetchArchivedItemsData()
        }
        
        private func fetchProfileData() {
            do {
                let descriptor = FetchDescriptor<Profile>()
                profile = try modelContext.fetch(descriptor).first ?? Profile.configMockProfile()
            } catch {
                print("Profile fetch for Profile viewModel failed")
            }
        }
        
        private func fetchItemsData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>()
                items = try modelContext.fetch(descriptor)
                unlockedItems = items.filter { $0.enabled }
                readyItems = items.filter { $0.ready }
            } catch {
                print("ConsumableItem fetch for Profile viewModel failed")
            }
        }
        
        private func fetchArchivedItemsData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { $0.archived }, sortBy: [SortDescriptor(\.price)])
                archivedItems = try modelContext.fetch(descriptor)
            } catch {
                print("ConsumableItem fetch for Profile viewModel failed")
            }
        }
        
        private func fetchActualRariries() {
            actualRarities = Rarity.allCases.filter { rarityCount(for: $0) > 0 }
        }
    }
}
