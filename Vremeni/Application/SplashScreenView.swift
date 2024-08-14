//
//  SplashScreenView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/14/24.
//

import SwiftUI
import SwiftData

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    internal var body: some View {
        if isActive {
            ShopView(modelContext: modelContext)
        } else {
            content
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
    
    private var content: some View {
        ZStack {
            Color.BackColors.backSplash
                .ignoresSafeArea()
            VStack {
                Image.SplashScreen.logo
                    .resizable()
                    .scaledToFit()
                    .frame(height: 600)
            }
        }
    }
}

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
