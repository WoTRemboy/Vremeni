//
//  SplashScreenView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/14/24.
//

import SwiftUI
import SwiftData

struct SplashScreenView: View {
    
    // MARK: - Properties
    
    // Show splash screen toggle
    @State private var isActive = false
    
    // ViewModel property
    private let modelContext: ModelContext
    
    // MARK: - Initialization
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Body view
    
    internal var body: some View {
        if isActive {
            // Step to the main view
            OnboardingScreenView(modelContext: modelContext)
                .environmentObject(OnboardingViewModel())
        } else {
            // Shows splash screnn
            content
                .onAppear {
                    // Then hides view after 0.5s
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
    
    // MARK: - Main vontent
    
    private var content: some View {
        ZStack {
            // Background color
            Color.BackColors.backSplash
                .ignoresSafeArea()
            
            // Logo image
            Image.SplashScreen.logo
                .resizable()
                .scaledToFit()
                .frame(height: 600)
        }
    }
}

// MARK: - Preview

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Profile.self, configurations: config)
        let modelContext = ModelContext(container)
        
        return SplashScreenView(modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
