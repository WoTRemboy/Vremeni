//
//  VremeniApp.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 23.07.2024.
//

import SwiftUI
import SwiftData

@main
struct VremeniApp: App {
    var body: some Scene {
        WindowGroup {
            ShopView()
        }
        .modelContainer(for: ConsumableItem.self)
    }
}
