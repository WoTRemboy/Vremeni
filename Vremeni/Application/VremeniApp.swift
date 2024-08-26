//
//  VremeniApp.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 23.07.2024.
//

import SwiftUI
import SwiftData
import UserNotifications

@main
struct VremeniApp: App {
    
    // MARK: - Properties
    
    // UserDefaults for user notifications status
    @AppStorage(Texts.UserDefaults.notifications) private var notificationsEnabled: NotificationStatus = .prohibited
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
        requestNotifications()
    }
    
    // MARK: - Notifications Request
    
    // Requests user for alert & sound notifications
    private func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                // User allowes notifications & they become active
                if self.notificationsEnabled == .prohibited {
                    self.notificationsEnabled = .allowed
                }
                print("Notifications are allowed.")
            } else if let error {
                // In error case notifications become prohibited
                self.notificationsEnabled = .prohibited
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Notifications Model

enum NotificationStatus: String {
    case allowed = "allowed"
    case disabled = "disabled"
    case prohibited = "prohibited"
}
