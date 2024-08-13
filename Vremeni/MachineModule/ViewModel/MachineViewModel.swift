//
//  MachineViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import Foundation
import SwiftUI
import SwiftData

extension MachineView {
    
    @Observable
    final class MachineViewModel {
        private let modelContext: ModelContext
        
        private(set) var profile = Profile.configMockProfile()
        private(set) var items = [MachineItem]()
        private(set) var timer = Timer()
        
        private let availableSlots = 1
        private let updateInterval: TimeInterval = 0.3
        private let targetPercent: CGFloat = 100
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        
        internal func updateOnAppear() {
            fetchProfileData()
            fetchData()
        }
        
        internal func setWorkshop(item: MachineItem) {
            item.setMachineTime()
            item.progressStart()
            fetchData()
        }
        
        internal func progressDismiss(item: MachineItem) {
            item.progressDismiss()
            fetchData()
        }
        
        internal func progressReady(item: MachineItem) {
            item.readyToggle()
            profile.addCoins(item.price)
            deleteItem(item: item)
        }
        
        internal func deleteItem(item: MachineItem) {
            item.inProgress = false
            item.parent.machineItems.removeAll(where: { $0.id == item.id })
            modelContext.delete(item)
            fetchData()
        }
        
        internal func remainingTime(for item: MachineItem) -> String {
            item.setMachineTime()
            return Date.itemShortFormatter.string(from: item.target)
        }
        
        internal func isSlotAvailable() -> Bool {
            let progressItems = items.filter({ $0.inProgress })
            return progressItems.count < availableSlots
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
        
        internal func startProgress(for item: MachineItem) {
            timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { timer in
                if item.percent < self.targetPercent {
                    let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: .now, to: item.target)
                    print(timeDifference, item.target)
                    self.percentTimeElapsed(for: item)
                } else {
                    timer.invalidate()
                }
            }
            timer.fire()
        }
        
        internal func stopProgress() {
            timer.invalidate()
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


