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
    @StateObject private var bannerService = BannerViewModel()
    private let container: ModelContainer
    
    
    internal var body: some Scene {
        WindowGroup {
            SplashScreenView(modelContext: container.mainContext)
        }
        .modelContainer(container)
        .environmentObject(bannerService)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Profile.self)
        } catch {
            fatalError("Failed to create ModelContainer for Profile.")
        }
    }
}
