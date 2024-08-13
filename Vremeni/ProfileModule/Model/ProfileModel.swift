//
//  ProfileModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/10/24.
//

import Foundation
import SwiftData

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
    
    internal static func configMockProfile() -> Profile {
        Profile(name: "Mock User", balance: 228, items: [])
    }
}
