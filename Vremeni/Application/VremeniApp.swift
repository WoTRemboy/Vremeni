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
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ShopView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: ConsumableItem.self)
        } catch {
            fatalError("Failed to create ModelContainer for ConsumableItem.")
        }
    }
}
