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
    
    internal func unlockItem(for price: Float) {
        balance -= Int(price)
    }
    
    internal func slotPurchase(internalPrice: Double) {
        balance -= Int(internalPrice)
        internalMachines += 1
    }
    
    internal func slotPurchase() {
        donateMachines += 1
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
    
    internal var id: Self { self }
    
    internal var name: String {
        switch self {
        case .research:
            Texts.ProfilePage.Stats.research
        case .inventory:
            Texts.ProfilePage.Stats.inventory
        }
    }
}


enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    internal var name: String {
        switch self {
        case .systemDefault:
            Texts.ProfilePage.system
        case .light:
            Texts.ProfilePage.light
        case .dark:
            Texts.ProfilePage.dark
        }
    }
    
    internal func color(_ scheme: ColorScheme) -> Color {
        switch self {
        case .systemDefault:
            scheme == .light ? Color.orange : Color.blue
        case .light:
            Color.orange
        case .dark:
            Color.blue
        }
    }
    
    internal var userInterfaceStyle: UIUserInterfaceStyle {
            switch self {
            case .systemDefault:
                return .unspecified
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
    
    internal var colorScheme: ColorScheme? {
        switch self {
        case .systemDefault:
            nil
        case .light:
            ColorScheme.light
        case .dark:
            ColorScheme.dark
        }
    }
}
