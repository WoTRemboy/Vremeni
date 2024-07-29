//
//  MachineViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import Foundation
import SwiftUI

final class MachineViewModel: ObservableObject {
    
    @Published private(set) var percent: CGFloat = 0
    @Published private(set) var timer = Timer()
    
    private let updateInterval: TimeInterval = 0.3
    private let targetPercent: CGFloat = 100
    
    internal func percentTimeElapsed(for item: ConsumableItem) {
        let totalTime = item.target.timeIntervalSince(item.started)
        let currentTime = Date().timeIntervalSince(item.started)
        
        let percent = currentTime / totalTime * 100
        if percent < targetPercent {
            self.percent = percent
        } else {
            self.percent = targetPercent
            item.readyToggle()
        }
    }
    
    internal func startProgress(for item: ConsumableItem) {
        timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { timer in
            if self.percent < self.targetPercent {
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

}
