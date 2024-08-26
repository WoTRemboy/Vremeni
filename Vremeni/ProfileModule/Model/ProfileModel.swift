//
//  ProfileModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/10/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Profile: Identifiable {
    var id = UUID()
    var name: String
    var balance: Int
    var internalMachines: Int
    var donateMachines: Int
    @Relationship(deleteRule: .cascade) var items: [ConsumableItem]
    
    init(id: UUID = UUID(), name: String, balance: Int, items: [ConsumableItem]) {
        self.id = id
        self.name = name
        self.balance = balance
        self.items = items
        self.internalMachines = 1
        self.donateMachines = 0
    }
}

extension Profile: Equatable {
    static internal func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.name == rhs.name && lhs.balance == rhs.balance
    }
    
    internal func changeName(to username: String) {
        name = username
    }
    
    internal func addCoins(_ count: Float) {
        balance += Int(count)
    }
    
    internal func slotPurchase(price: Double) {
        balance -= Int(price)
        internalMachines += 1
    }
    
    internal func resetStacks() {
        balance = 0
        internalMachines = 1
    }
    
    internal static func configMockProfile() -> Profile {
        Profile(name: "Mock User", balance: 228, items: [])
    }
}


enum ChartType: String, Identifiable, CaseIterable {
    case research = "Research"
    case inventory = "Inventory"
    
    var id: Self { self }
}


enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    internal func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            scheme == .light ? Color.Tints.orange : Color.Tints.blue
        case .light:
            Color.Tints.orange
        case .dark:
            Color.Tints.blue
        }
    }
}
