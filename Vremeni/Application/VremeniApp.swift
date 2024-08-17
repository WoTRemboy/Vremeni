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
            ZStack {
                SplashScreenView(modelContext: container.mainContext)
                
                if let type = bannerService.bannerType {
                    BannerView(type: type)
                }
            }
            .environmentObject(bannerService)
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
