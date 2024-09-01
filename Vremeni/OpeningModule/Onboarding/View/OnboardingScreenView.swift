//
//  OnboardingScreenView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI
import SwiftData

struct OnboardingScreenView: View {
    
    @EnvironmentObject private var viewModel: OnboardingViewModel
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    internal var body: some View {
        if viewModel.isActive {
            ShopView(modelContext: modelContext)
        } else {
            VStack {
                skipButton
                content
                progressCircles
                actionButton
            }
        }
    }
    
    private var skipButton: some View {
        HStack {
            Spacer()
            Button {
                viewModel.skipSteps()
            } label: {
                Text(Texts.OnboardingPage.skip)
                    .font(.body())
                    .foregroundStyle(Color.LabelColors.labelSecondary)
                    .padding(.horizontal)
            }

        }
    }
    
    private var content: some View {
        TabView(selection: $viewModel.currentStep) {
            ForEach(0 ..< viewModel.stepsCount, id: \.self) { index in
                VStack(spacing: 16) {
                    viewModel.steps[index].image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .clipShape(.buttonBorder)
                    
                    Text(viewModel.steps[index].name)
                        .font(.largeTitle())
                        .padding(.top)
                    
                    Text(viewModel.steps[index].description)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    private var progressCircles: some View {
        HStack {
            ForEach(0 ..< viewModel.stepsCount, id: \.self) { step in
                if step == viewModel.currentStep {
                    Rectangle()
                        .frame(width: 20, height: 10)
                        .clipShape(.buttonBorder)
                        .foregroundStyle(Color.Tints.blue)
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color.LabelColors.labelDisable)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }
    
    private var actionButton: some View {
        Button {
            switch viewModel.buttonType {
            case .nextPage:
                viewModel.nextStep()
            case .getStarted:
                viewModel.getStarted()
            }
        } label: {
            switch viewModel.buttonType {
            case .nextPage:
                Text(Texts.OnboardingPage.next)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            case .getStarted:
                Text(Texts.OnboardingPage.started)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .minimumScaleFactor(0.4)
        
        .foregroundStyle(viewModel.buttonType == .nextPage ? Color.orange : Color.green)
        .tint(viewModel.buttonType == .nextPage ? Color.orange : Color.green)
        .buttonStyle(.bordered)
        
        .padding(.horizontal)
        .padding(.vertical, 30)
        
        .animation(.easeInOut, value: viewModel.buttonType)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let enviromentObject = OnboardingViewModel()
        
        return OnboardingScreenView(modelContext: modelContext)
            .environmentObject(enviromentObject)

    } catch {
        fatalError("Failed to create model container.")
    }
}
