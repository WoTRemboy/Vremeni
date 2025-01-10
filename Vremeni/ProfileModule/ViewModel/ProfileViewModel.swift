//
//  ProfileViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import Foundation
import SwiftData
import SwiftUI
import UserNotifications

extension ProfileView {
    
    @Observable
    final class ProfileViewModel {
        private let modelContext: ModelContext
        
        private(set) var profile = Profile.configMockProfile()
        private(set) var version: String = String()
        
        internal var notificationsEnabled: Bool = false
        internal var showingNotificationAlert: Bool = false
        private(set) var notificationsStatus: NotificationStatus = .prohibited
        
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
        
        internal var inventoryBalance: Int {
            readyItems.reduce(0) { $0 + (Int($1.price) * $1.count) }
        }
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        
        internal func updateOnAppear() {
            fetchProfileData()
            fetchItemsData()
            fetchArchivedItemsData()
            readNotificationStatus()
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
            return Int(Float(valuation) / Float(inventoryBalance) * 100)
        }
        
        internal func inventoryRarityCount(for rarity: Rarity) -> Int {
            let rarityItems = readyItems.filter { $0.rarity == rarity }
            return rarityItems.reduce(0) { $0 + $1.count }
        }
        
        internal func valuationCount(for rarity: Rarity) -> Int {
            let rarityItems = readyItems.filter { $0.rarity == rarity }
            return rarityItems.reduce(0) { $0 + ($1.count * Int($1.price)) }
        }
        
        internal func ruleDesctiption(item: ConsumableItem) -> [String] {
            // For the first item (One Hours) there are no requirements
            guard !item.requirements.isEmpty else { return [Texts.ItemCreatePage.null] }
            
            var rule = [String]()
            let requirements = item.requirements.sorted { $0.item.price > $1.item.price}
            for requirement in requirements {
                // Setups requirement string
                let requirementName = NSLocalizedString(requirement.item.nameKey, comment: String())
                let reqString = "\(requirementName) × \(requirement.quantity)"
                rule.append(reqString)
            }
            
            return rule
        }
        
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
        
        internal func changeTheme(theme: Theme) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.overrideUserInterfaceStyle = theme.userInterfaceStyle
                    })
                }
            }
        }
        
        internal func selectShape(_ theme: Theme) -> (CGSize, CGFloat) {
            switch theme {
            case .systemDefault:
                (CGSize(width: 0, height: 0), 90)
            case .light:
                (CGSize(width: 150, height: -150), 180)
            case .dark:
                (CGSize(width: 30, height: -25), 180)
            }
        }
        
        private func readNotificationStatus() {
            let defaults = UserDefaults.standard
            let rawValue = defaults.string(forKey: Texts.UserDefaults.notifications) ?? String()
            notificationsStatus = NotificationStatus(rawValue: rawValue) ?? .prohibited
            
            guard notificationsStatus == .allowed else { return }
            notificationsEnabled = true
        }
        
        internal func setNotificationsStatus(allowed: Bool) {
            let defaults = UserDefaults.standard
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
                if success {
                    self.notificationsStatus = allowed ? .allowed : .disabled
                    print("Notifications are set to \(allowed).")
                } else if let error {
                    print(error.localizedDescription)
                } else {
                    self.notificationsStatus = .prohibited
                    self.notificationsEnabled = false
                    self.showingNotificationAlert = true
                    print("Notifications are prohibited.")
                }
                defaults.set(self.notificationsStatus.rawValue, forKey: Texts.UserDefaults.notifications)
            }
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
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            profile.resetStacks()
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
            let oneMinute = ConsumableItem.itemConfig(nameKey: Content.Common.oneMinuteTitle,
                                                        descriptionKey: Content.Common.oneMinuteDescription,
                                                        price: 1,
                                                        premium: false, profile: profile,
                                                        applications: [RuleItem.threeHours.rawValue : 3,
                                                                       RuleItem.fiveHours.rawValue : 5,
                                                                       RuleItem.sevenHours.rawValue : 7]
                                                       )
            
            let threeMinutes = ConsumableItem.itemConfig(nameKey: Content.Common.threeMinutesTitle,
                                                           descriptionKey: Content.Common.threeMinutesDescription,
                                                           price: 3,
                                                           premium: false, rarity: .common,
                                                           profile: profile,
                                                           requirements: [Requirement(item: oneMinute, quantity: 3)],
                                                           applications: [RuleItem.fiveHours.rawValue : 5,
                                                                          RuleItem.tenHours.rawValue : 10],
                                                           enabled: false)
            
            let fiveMinutes = ConsumableItem.itemConfig(nameKey: Content.Uncommon.fiveMinutesTitle,
                                                            descriptionKey: Content.Uncommon.fiveMinutesDescription,
                                                            price: 5,
                                                            premium: false, rarity: .uncommon,
                                                            profile: profile,
                                                            requirements: [Requirement(item: oneMinute, quantity: 2), Requirement(item: threeMinutes, quantity: 1)],
                                                            applications: [RuleItem.sevenHours.rawValue : 7],
                                                            enabled: false)
            
            let sevenMinutes = ConsumableItem.itemConfig(nameKey: Content.Uncommon.sevenMinutesTitle,
                                                             descriptionKey: Content.Uncommon.sevenMinutesDescription,
                                                             price: 7,
                                                             premium: false, rarity: .uncommon,
                                                             profile: profile,
                                                             requirements: [Requirement(item: fiveMinutes, quantity: 1), Requirement(item: oneMinute, quantity: 2)],
                                                             applications: [RuleItem.tenHours.rawValue : 10],
                                                             enabled: false)
            
            let tenMinutes = ConsumableItem.itemConfig(nameKey: Content.Rare.tenMinutesTitle,
                                                           descriptionKey: Content.Rare.tenMinutesDescription,
                                                           price: 10,
                                                           premium: false, rarity: .rare,
                                                           profile: profile,
                                                           requirements: [Requirement(item: sevenMinutes, quantity: 1), Requirement(item: threeMinutes, quantity: 1)],
                                                           enabled: false)
            
            let items = [oneMinute, threeMinutes, fiveMinutes, sevenMinutes, tenMinutes]
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
