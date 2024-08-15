//
//  ChartsDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/15/24.
//

import SwiftUI
import SwiftData

struct ChartsDetailsView: View {
    
    @State private var selectedChartType: ChartType = .pie
    private var viewModel: ProfileView.ProfileViewModel
    
    init(viewModel: ProfileView.ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    picker
                    
                    switch selectedChartType {
                    case .pie:
                        StatsPieChartView(viewModel: viewModel)
                        pieStats
                    case .bar:
                        Text(Texts.ProfilePage.Stats.bar)
                    }
                    
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle(Texts.ProfilePage.Stats.title)
            .navigationBarTitleDisplayMode(.inline)
            
            .onAppear {
                viewModel.updateStatsOnAppear()
            }
        }
    }
    
    private var picker: some View {
        Picker(Texts.ProfilePage.Stats.type, selection: $selectedChartType) {
            ForEach(ChartType.allCases) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    private var pieStats: some View {
        VStack {
            ForEach(viewModel.actualRarities) { rarity in
                ParameterRow(title: rarity.rawValue,
                content: "\(Texts.ProfilePage.Stats.unlocked) \(viewModel.rarityCount(for: rarity)) \(Texts.ProfilePage.Stats.of) \(viewModel.rarityCount(for: rarity, all: true)) (\(viewModel.rarityPercent(for: rarity))%)")
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        viewModel.addSamples()
        return ChartsDetailsView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
