//
//  ProfileViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import Foundation
import SwiftData

extension ProfileView {
    
    @Observable
    final class ProfileViewModel {
        private let modelContext: ModelContext
        
        private(set) var profile = Profile.configMockProfile()
        private(set) var version: String = String()
        
        private var items = [ConsumableItem]()
        private var unlockedItems = [ConsumableItem]()
        private(set) var archivedItems = [ConsumableItem]()
        
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
        
        internal var itemsCount: Int {
            items.count
        }
        
        internal func rarityCount(for rarity: Rarity) -> Int {
            guard rarity != .all else { return unlockedItems.count }
            return unlockedItems.filter({ $0.rarity == rarity }).count
        }
        
        internal func updateVersionOnAppear() {
            versionDetect()
        }
        
        internal func changeNickname(to name: String) {
            profile.changeName(to: name)
            fetchProfileData()
        }
        
        internal func resetProgress() {
            // reset progress
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
                                                       count: 5,
                                                       profile: profile,
                                                       archived: true),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       count: 3,
                                                       rarity: .common,
                                                       profile: profile,
                                                       archived: true),
                         
                         ConsumableItem.itemMockConfig(name: "Three Minutes",
                                                       description: "Three minutes is a whole 180 seconds!",
                                                       price: 3,
                                                       count: 3,
                                                       rarity: .rare,
                                                       profile: profile,
                                                       archived: true)]
            for item in items {
                modelContext.insert(item)
            }
            fetchItemsData()
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
    }
}
