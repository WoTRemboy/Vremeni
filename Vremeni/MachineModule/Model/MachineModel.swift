//
//  MachineModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import Foundation
import SwiftData

// MARK: - MachineItem Model

@Model
final class MachineItem: Identifiable {
    
    // General
    var id = UUID()
    var nameKey: String
    var descriptionKey: String
    
    @Attribute(.externalStorage)
    var image: Data?
    
    // General localized
    var name: String {
        NSLocalizedString(nameKey, comment: String())
    }
    var itemDescription: String {
        NSLocalizedString(descriptionKey, comment: String())
    }
    
    // Valuation
    var price: Float
    // Progress status
    var percent: Double
    var status: MachineStatus
    
    // MashineItem type
    var type: VremeniType
    var rarity: Rarity
    // Data base relationship
    var parent: ConsumableItem
    
    // Research applications (Item name + Price)
    var applications: [String: Int]
    
    // Progress checks
    var started: Date = Date()
    var target: Date = Date()
    
    init(id: UUID = UUID(), nameKey: String, descriptionKey: String, image: Data? = nil,
         price: Float, percent: Double = 0, status: MachineStatus = .queued,
         type: VremeniType = .minutes, rarity: Rarity = .common, parent: ConsumableItem, applications: [String: Int]) {
        self.id = id
        self.nameKey = nameKey
        self.descriptionKey = descriptionKey
        self.image = image
        self.price = price
        self.percent = percent
        self.status = status
        self.type = type
        self.rarity = rarity
        self.parent = parent
        self.applications = applications
    }
}

// MARK: - MachineItem Methods

extension MachineItem {
    // Changes to ready when workshop status is 100%
    internal func readyToggle() {
        parent.ready = true
        // Adds item valuation to Profile balance
        parent.countPlus()
        status = .queued
    }
    
    internal func pendingStart() {
        status = .pending
    }
    
    // Begins workshop processing
    internal func progressStart() {
        status = .processing
    }
    
    // Ends/Cancels workshop processing
    internal func progressDismiss() {
        status = .queued
    }
    
    // Sets start and target dates
    internal func setMachineTime() {
        // When it's first time
        if percent == 0 {
            started = .now
            target = .now.addingTimeInterval(TimeInterval(price * 60))
        // Resumes after pause
        } else {
            let passedTime = TimeInterval((price * 60) * Float(percent / 100))
            let remainTime = (price * 60) * Float(1 - percent / 100)
            started = .now.addingTimeInterval(-passedTime)
            target = .now.addingTimeInterval(TimeInterval(remainTime))
        }
    }
    
    internal func setPendingTime(front: MachineItem?) {
        // When it's first time
        guard let front else { return }
        if percent == 0 {
            started = front.target
            target = front.target.addingTimeInterval(TimeInterval(price * 60))
        // Resumes after pause
        } else {
            let passedTime = TimeInterval((price * 60) * Float(percent / 100))
            let remainTime = (price * 60) * Float(1 - percent / 100)
            started = front.target.addingTimeInterval(-passedTime)
            target = front.target.addingTimeInterval(TimeInterval(remainTime))
        }
    }
    
    // Configurates MachineItem mock data
    static internal func itemMockConfig(name: String, description: String = String(),
                                        price: Float, image: Data? = nil,
                                        inProgress: Bool = false,
                                        rarity: Rarity = .common, profile: Profile,
                                        applications: [String: Int] = [:]) -> MachineItem {
        let name = name
        let description = description
        let image = image
        let price = price
        let rarity = rarity
        let profile = profile
        let parent = ConsumableItem.itemMockConfig(nameKey: name, price: price, profile: profile)
        let applications = applications
        
        return MachineItem(nameKey: name, descriptionKey: description, image: image, price: price, rarity: rarity, parent: parent, applications: applications)
    }
}

// MARK: - Workshop upgrade Model

enum UpgrageMethod: String {
    case coins = "Local currency"
    case money = "Real currency"
    
    internal var name: String {
        switch self {
        case .coins:
            Texts.MachinePage.Upgrade.coins
        case .money:
            Texts.MachinePage.Upgrade.real
        }
    }
}

enum MachineStatus: Codable {
    case queued
    case pending
    case processing
}
