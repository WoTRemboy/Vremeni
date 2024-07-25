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
    
    private let updateInterval: TimeInterval = 1.0
    private let targetPercent: CGFloat = 100
    
    internal func percentTimeElapsed(from addedDate: Date, to targetDate: Date, currentDate: Date = Date()) {
        let addedTime = addedDate.timeIntervalSince1970
        let totalTime = targetDate.timeIntervalSinceNow
        let elapsedTime = currentDate.timeIntervalSince1970
        
        let percent = (elapsedTime - addedTime) / totalTime * 100
        if percent < targetPercent {
            self.percent = (elapsedTime - addedTime) / totalTime * 100
        } else {
            self.percent = targetPercent
        }
    }
    
    internal func startProgress(from added: Date, to target: Date) {
        timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { timer in
            if self.percent < self.targetPercent {
                let timeDifference = Calendar.current.dateComponents([.hour, .minute, .second], from: .now, to: target)
                print(timeDifference, target)
                
                withAnimation {
                    self.percentTimeElapsed(from: added, to: target)
                }
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
