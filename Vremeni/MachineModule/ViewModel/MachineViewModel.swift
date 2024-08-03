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
        
        private(set) var items = [ConsumableItem]()
        private(set) var timer = Timer()
        
        private let availableSlots = 1
        private let updateInterval: TimeInterval = 0.3
        private let targetPercent: CGFloat = 100
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        internal func updateOnAppear() {
            fetchData()
        }
        
        internal func setWorkshop(item: ConsumableItem) {
            item.setMachineTime()
            item.progressToggle()
            fetchData()
        }
        
        internal func progressDismiss(item: ConsumableItem) {
            item.progressDismiss()
            fetchData()
        }
        
        internal func deleteItem(item: ConsumableItem) {
            modelContext.delete(item)
            fetchData()
        }
        
        internal func isSlotAvailable() -> Bool {
            let progressItems = items.filter({ $0.inProgress })
            return progressItems.count == availableSlots
        }
        
        internal func percentTimeElapsed(for item: ConsumableItem) {
            let totalTime = item.target.timeIntervalSince(item.started)
            let currentTime = Date().timeIntervalSince(item.started)
            
            let percent = currentTime / totalTime * 100
            if percent < targetPercent {
                item.percent = percent
            } else {
                item.percent = targetPercent
                item.readyToggle()
            }
        }
        
        internal func startProgress(for item: ConsumableItem) {
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
        
        private func fetchData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { $0.inMachine || $0.inProgress }, sortBy: [SortDescriptor(\.percent, order: .reverse), SortDescriptor(\.started), SortDescriptor(\.price)])
                items = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }

    }
}


