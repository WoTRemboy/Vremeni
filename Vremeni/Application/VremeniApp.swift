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
    // UserDefaults for current app theme
    @AppStorage(Texts.UserDefaults.theme) private var userTheme: Theme = .systemDefault
    // Banner manager
    @StateObject private var bannerService = BannerViewModel()
    // StoreKit manager
    @StateObject private var storeKitService = StoreKitManager()
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
            .task {
                await storeKitService.fetchProducts()
            }
            // Banner manager environment
            .environmentObject(bannerService)
            // StoreKit manager environment
            .environmentObject(storeKitService)
            // App theme style setup
            .onAppear {
                setTheme(style: userTheme.userInterfaceStyle)
            }
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
    
    // MARK: - Appearance setup
    
    private func setTheme(style: UIUserInterfaceStyle) {
        // System style by default
        guard style != .unspecified else { return }
        // Setups a theme style without animation
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.overrideUserInterfaceStyle = style
            }
        }
    }
}

// MARK: - Notifications

// Notifications Model
enum NotificationStatus: String {
    case allowed = "allowed"
    case disabled = "disabled"
    case prohibited = "prohibited"
}

// Notifications Method
extension VremeniApp {
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
