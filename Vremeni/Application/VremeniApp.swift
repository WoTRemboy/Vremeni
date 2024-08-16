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
    private let container: ModelContainer
    
    internal var body: some Scene {
        WindowGroup {
            SplashScreenView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Profile.self)
        } catch {
            fatalError("Failed to create ModelContainer for Profile.")
        }
    }
}
