//
//  ShopModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftData

@Model
final class ConsumableItem: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let price: Int
    let added: Date
    var started: Date
    var target: Date
    var inProgress: Bool
    var ready: Bool
    
    init(name: String, image: String, price: Int, added: Date, started: Date, target: Date, inProgress: Bool = false, ready: Bool = false) {
        self.name = name
        self.image = image
        self.price = price
        self.added = added
        self.started = started
        self.target = target
        self.inProgress = inProgress
        self.ready = ready
    }
}

extension ConsumableItem {
    
    internal func readyToggle() {
        ready = true
        inProgress = false
    }
    
    internal func progressToggle() {
        ready = false
        inProgress = true
    }
    
    internal func setMachineTime() {
        started = .now
        target = .now.addingTimeInterval(TimeInterval(price * 60))
    }
    
    static internal func itemMockConfig(name: String, price: Int) -> ConsumableItem {
        let name = name
        let image = "\(price).square"
        let price = price
        let added = Date.now
        let started = Date.now
        let target = added.addingTimeInterval(TimeInterval(price * 60))
        
        return ConsumableItem(name: name, image: image, price: price, added: added, started: started, target: target)
    }
}
