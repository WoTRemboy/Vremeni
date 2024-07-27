//
//  ShopModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import SwiftUI

struct ConsumableItem: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let price: Int
    let added: Date
    let started: Date
    let target: Date
    var ready: Bool
    
    mutating func toggleReady() {
        ready.toggle()
    }
    
    static internal func itemMockConfig(name: String, price: Int) -> ConsumableItem {
        let name = name
        let image = "\(price).square"
        let price = price
        let added = Date.now
        let started = Date.now
        let target = added.addingTimeInterval(TimeInterval(price * 60))
        
        return ConsumableItem(name: name, image: image, price: price, added: added, started: started, target: target, ready: false)
    }
    
    static internal func itemsMockConfig() -> [ConsumableItem] {
        let items = [itemMockConfig(name: "One Hour", price: 1),
                     itemMockConfig(name: "Two Hours", price: 2),
                     itemMockConfig(name: "Three Hours", price: 3),
                     itemMockConfig(name: "Five Hours", price: 5),
                     itemMockConfig(name: "Eight Hours", price: 8),
                     itemMockConfig(name: "Twelve Hours", price: 12),
                     itemMockConfig(name: "Eighteen Hours", price: 18),
                     itemMockConfig(name: "Twenty Four Hours", price: 24)
        ]
        return items
    }
}
