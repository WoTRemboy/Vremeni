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
    
    // MARK: - Properties
    
    // Banner viewModel
    @StateObject private var bannerService = BannerViewModel()
    // SwiftData container
    private let container: ModelContainer
    
    // MARK: - Body view
    
    internal var body: some Scene {
        WindowGroup {
            ZStack {
                // Main views
                SplashScreenView(modelContext: container.mainContext)
                
                // Banner view
                if let type = bannerService.bannerType {
                    BannerView(type: type)
                }
            }
            // Banner viewModel environment
            .environmentObject(bannerService)
        }
        // SwiftData model container
        .modelContainer(container)
    }
    
    // MARK: - Initialization
    
    init() {
        do {
            container = try ModelContainer(for: Profile.self)
        } catch {
            fatalError("Failed to create ModelContainer for Profile.")
        }
    }
}
