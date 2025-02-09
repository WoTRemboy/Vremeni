//
//  OnboardingScreenView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI
import SwiftData
import SwiftUIPager

struct OnboardingScreenView: View {
    
    @StateObject private var viewModel = OnboardingViewModel()
    
    /// Current page tracker for the pager.
    @StateObject private var page: Page = .first()
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    internal var body: some View {
        if viewModel.skipOnboarding {
            RootView(modelContext: modelContext)
        } else {
            VStack {
                skipButton
                content
                progressCircles
                selectPageButtons
            }
            .onChange(of: page.index) { _, newValue in
                withAnimation {
                    viewModel.setupCurrentStep(newValue: newValue)
                }
            }
        }
    }
    
    private var skipButton: some View {
        HStack {
            Spacer()
            Text(Texts.OnboardingPage.skip)
                .font(.body)
                .foregroundStyle(viewModel.buttonType == .nextPage ? Color.labelSecondary : Color.clear)
                .padding(.horizontal)
                .padding(.top)
            
                .onTapGesture {
                    withAnimation {
                        page.update(.moveToLast)
                    }
                }
        }
        .disabled(viewModel.buttonType == .getStarted)
    }
    
    private var content: some View {
        Pager(page: page,
              data: viewModel.pages,
              id: \.self) { index in
            VStack(spacing: 16) {
                viewModel.steps[index].image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text(viewModel.steps[index].name)
                    .font(.largeTitle())
                    .padding(.top)
                
                Text(viewModel.steps[index].description)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            .tag(index)
        }
              .interactive(scale: 0.8)
              .itemSpacing(10)
              .itemAspectRatio(1.0)
        
              .swipeInteractionArea(.allAvailable)
              .multiplePagination()
              .horizontal()
    }
    
    private var progressCircles: some View {
        HStack {
            ForEach(viewModel.pages, id: \.self) { step in
                if step == page.index {
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color.Tints.blue)
                        .transition(.scale)
                } else {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(Color.labelDisable)
                        .transition(.scale)
                }
            }
        }
    }
    
    private var selectPageButtons: some View {
        VStack(spacing: 16) {
            switch viewModel.buttonType {
            case .nextPage:
                actionButton
                    .transition(.move(edge: .leading).combined(with: .opacity))
            case .getStarted:
                actionButton
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
    }
    
    private var actionButton: some View {
        Button {
            switch viewModel.buttonType {
            case .nextPage:
                withAnimation {
                    page.update(.next)
                }
            case .getStarted:
                withAnimation {
                    viewModel.transferToMainPage()
                }
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
