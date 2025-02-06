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
    @State private var id = 0
    
    // ViewModel property
    private let modelContext: ModelContext
    private let appIcon: Icon
    private let texts = [String(), Texts.Common.title]
    
    // MARK: - Initialization
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        let iconName = UIApplication.shared.alternateIconName
        if let iconName {
            appIcon = Icon(rawValue: iconName) ?? Icon.primary
        } else {
            appIcon = .primary
        }
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
    
    // MARK: - Main vontent
    
    private var content: some View {
        VStack(spacing: 2) {
            Image(appIcon.splashName)
                .resizable()
                .frame(width: 300, height: 300)
            
            Text(texts[id])
                .foregroundStyle(Color(appIcon.splashColor))
                .font(.system(size: 80, weight: .medium))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.horizontal, 30)
        }
        .contentTransition(.numericText())
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
                withAnimation {
                    id += 1
                }
            }
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
