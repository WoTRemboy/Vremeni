//
//  ChartsDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/15/24.
//

import SwiftUI
import SwiftData

struct ChartsDetailsView: View {
    
    private var selectedChartType: ChartType = .research
    private var viewModel: ProfileView.ProfileViewModel
    
    init(type: ChartType, viewModel: ProfileView.ProfileViewModel) {
        self.selectedChartType = type
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    switch selectedChartType {
                    case .research:
                        researchChart
                        researchStats
                        
                    case .inventory:
                        inventoryChart
                        
                        if viewModel.inventoryRarities.count > 0 {
                            inventoryStats
                        }
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
    
    private var researchChart: some View {
        StatisticsChartView(viewModel: viewModel)
            .frame(maxWidth: .infinity, idealHeight: 300, alignment: .center)
    }
    
    private var researchStats: some View {
        VStack {
            SectionHeader(Texts.ProfilePage.Stats.progress)
                .padding(.leading)
            ForEach(viewModel.rariries) { rarity in
                ParameterRow(title: rarity.name,
                content: "\(Texts.ProfilePage.Stats.unlocked) \(viewModel.rarityCount(for: rarity)) \(Texts.ProfilePage.Stats.of) \(viewModel.rarityCount(for: rarity, all: true))",
                trailingContent: "\(viewModel.rarityPercent(for: rarity))%")
            }
        }
        .padding(.bottom, 8)
    }
    
    private var inventoryChart: some View {
        StatsBarChartView(type: .inventory, viewModel: viewModel)
            .frame(minHeight: viewModel.inventoryRarities.count > 0 ? 130 : 300,
                   idealHeight: viewModel.inventoryRarities.count > 0 ? CGFloat(100 * viewModel.inventoryRarities.count) : 120
            )
    }
    
    private var inventoryStats: some View {
        VStack {
            SectionHeader(Texts.ProfilePage.Stats.balance)
                .padding(.leading)
            ForEach(viewModel.rariries) { rarity in
                ParameterRow(title: rarity.name,
                             content: "\(Texts.ProfilePage.Stats.valuation): \(viewModel.valuationCount(for: rarity))",
                             trailingContent: "\(viewModel.valuationPercent(for: rarity))%")
            }
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        viewModel.addSamples()
        return ChartsDetailsView(type: .research, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
