//
//  ChartsDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/15/24.
//

import SwiftUI
import SwiftData

struct ChartsDetailsView: View {
    
    @State private var selectedChartType: ChartType = .research
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
                    case .research:
                        researchChart
                            .transition(.move(edge: .leading))
                        researchStats
                            .transition(.move(edge: .leading))
                        
                    case .inventory:
                        inventoryChart
                            .transition(.move(edge: .trailing))
                        
                        if viewModel.inventoryRarities.count > 0 {
                            inventoryStats
                                .transition(.move(edge: .trailing))
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
    
    private var picker: some View {
        Picker(Texts.ProfilePage.Stats.type, selection: $selectedChartType.animation()) {
            ForEach(ChartType.allCases) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    private var researchChart: some View {
        StatsBarChartView(type: .research, viewModel: viewModel)
            .frame(minHeight: 130,
                   idealHeight: CGFloat(100 * viewModel.actualRarities.count)
            )
    }
    
    private var researchStats: some View {
        VStack {
            SectionHeader(Texts.ProfilePage.Stats.progress)
                .padding(.leading)
            ForEach(viewModel.rariries) { rarity in
                ParameterRow(title: rarity.rawValue,
                content: "\(Texts.ProfilePage.Stats.unlocked) \(viewModel.rarityCount(for: rarity)) \(Texts.ProfilePage.Stats.of) \(viewModel.rarityCount(for: rarity, all: true)) (\(viewModel.rarityPercent(for: rarity))%)")
            }
        }
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
            ForEach(viewModel.inventoryRarities) { rarity in
                ParameterRow(title: rarity.rawValue,
                             content: "\(Texts.ProfilePage.Stats.valuation) \(viewModel.rarityCount(for: rarity)) (\(viewModel.valuationPercent(for: rarity))%)")
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
