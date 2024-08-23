//
//  MachineViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import Foundation
import SwiftUI
import SwiftData
import NotificationCenter

extension MachineView {
    
    @Observable
    final class MachineViewModel {
        private let modelContext: ModelContext
        
        private(set) var profile = Profile.configMockProfile()
        private(set) var items = [MachineItem]()
        private var timers: [UUID: Timer] = [:]
        
        private let updateInterval: TimeInterval = 0.3
        private let targetPercent: CGFloat = 100
        
        private(set) var selectedType: UpgrageMethod = .coins
        private(set) var readyNotification: (ready: Bool, name: String?) = (false, nil)
        private let slotsLimit = 3
        internal let internalPrice: Double = 1
        internal let donatePrice: Double = 0.99
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            NotificationCenter.default.addObserver(self, selector: #selector(handleResetProgress), name: .resetProgressNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(handleStartTimers), name: .startProgressNotification, object: nil)
        }
        
        @objc private func handleResetProgress() {
            stopAllTimers()
        }
        
        @objc private func handleStartTimers() {
            startTimers()
        }
        
        internal func updateOnAppear() {
            fetchProfileData()
            fetchData()
        }
        
        internal func setWorkshop(item: MachineItem) {
            item.setMachineTime()
            item.progressStart()
            startProgress(for: item)
            fetchData()
        }
        
        internal func progressDismiss(item: MachineItem) {
            item.progressDismiss()
            stopProgress(for: item)
            fetchData()
        }
        
        internal func progressReady(item: MachineItem) {
            profile.addCoins(item.price)
            readyNotification = (true, item.name)
            NotificationCenter.default.post(name: .inventoryUpdateNotification, object: nil)
            withAnimation(.bouncy) {
                item.readyToggle()
                deleteItem(item: item)
            }
        }
        
        internal func hideReadyNotification() {
            readyNotification = (false, nil)
        }
        
        internal func deleteItem(item: MachineItem) {
            item.inProgress = false
            item.parent.machineItems.removeAll(where: { $0.id == item.id })
            modelContext.delete(item)
            fetchData()
        }
        
        internal func startTimers() {
            updateOnAppear()
            for item in items.filter({ $0.inProgress }) {
                startProgress(for: item)
            }
        }
        
        internal func stopAllTimers() {
            for timer in timers.values {
                timer.invalidate()
            }
            timers.removeAll()
        }
        
        internal func remainingTime(for item: MachineItem) -> String {
            item.setMachineTime()
            return Date.itemShortFormatter.string(from: item.target)
        }
        
        internal func changePurchaseType(to selected: UpgrageMethod) {
            selectedType = selected
        }
        
        internal func slotLimitReached() -> Bool {
            profile.internalMachines >= slotsLimit
        }
        
        internal func isPurchaseUnavailable() -> Bool {
            guard selectedType != .money else { return true }
            return profile.balance < Int(internalPrice) || profile.internalMachines >= slotsLimit
        }
        
        internal func slotPurchase() {
            profile.slotPurchase(price: internalPrice)
        }
        
        internal func isSlotAvailable() -> Bool {
            let progressItems = items.filter({ $0.inProgress })
            let availableMachines = profile.internalMachines + profile.donateMachines
            return progressItems.count < availableMachines
        }
        
        internal func percentTimeElapsed(for item: MachineItem) {
            let totalTime = item.target.timeIntervalSince(item.started)
            let currentTime = Date().timeIntervalSince(item.started)
            
            let percent = currentTime / totalTime * 100
            if percent < targetPercent {
                item.percent = percent
            } else {
                item.percent = targetPercent
                progressReady(item: item)
            }
        }
        
        internal func activateMachineProgress() {
            let children = items.filter { $0.inProgress }
            for child in children {
                startProgress(for: child)
            }
        }
        
        internal func startProgress(for item: MachineItem) {
            guard timers[item.id] == nil else { return }
            let timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                
                if item.percent < self.targetPercent {
                    let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: .now, to: item.target)
                    print(timeDifference, item.target)
                    self.percentTimeElapsed(for: item)
                } else {
                    timer.invalidate()
                }
            }
            timers[item.id] = timer
            timer.fire()
        }
        
        internal func stopProgress(for item: MachineItem) {
            timers[item.id]?.invalidate()
            timers[item.id] = nil
        }
        
        internal func notificationSetup(for item: MachineItem) {
            let content = UNMutableNotificationContent()
            content.title = Texts.Common.title
            content.body = "«\(item.name)» \(Texts.Banner.ready)"
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: item.target.timeIntervalSinceNow, repeats: false)
            let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
        
        internal func notificationRemove(for id: UUID) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        }
        
        internal func addSamples() {
            let one = MachineItem.itemMockConfig(name: "one hour", price: 1, profile: Profile.configMockProfile())
            let two = MachineItem.itemMockConfig(name: "two hours", price: 2, profile: Profile.configMockProfile())
            let three = MachineItem.itemMockConfig(name: "three hours", price: 3, profile: Profile.configMockProfile())
            items = [one, two, three]
        }
        
        private func fetchData() {
            do {
                let descriptor = FetchDescriptor<MachineItem>(sortBy: [SortDescriptor(\.percent, order: .reverse), SortDescriptor(\.started), SortDescriptor(\.price)])
                items = try modelContext.fetch(descriptor)
            } catch {
                print("MachineItem fetch for Machine viewModel failed")
            }
        }
        
        private func fetchProfileData() {
            do {
                let descriptor = FetchDescriptor<Profile>()
                profile = try modelContext.fetch(descriptor).first ?? Profile.configMockProfile()
            } catch {
                print("Profile fetch for Machine viewModel failed")
            }
        }

    }
}


