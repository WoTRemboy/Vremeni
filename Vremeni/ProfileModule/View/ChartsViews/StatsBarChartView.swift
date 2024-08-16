//
//  StatsBarChartView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/16/24.
//

import SwiftUI
import SwiftData
import Charts

struct StatsBarChartView: View {
    
    private var viewModel: ProfileView.ProfileViewModel
    private let type: ChartType
    
    init(type: ChartType, viewModel: ProfileView.ProfileViewModel) {
        self.viewModel = viewModel
        self.type = type
    }
    
    internal var body: some View {
        if viewModel.inventoryRarities.count > 0 || type == .research {
            chart
        } else {
            PlaceholderView(title: Texts.ProfilePage.Stats.placeholderTitle,
                            description: Texts.ProfilePage.Stats.placeholderDesc, status: .stats)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var chart: some View {
        Chart(type == .research ? viewModel.actualRarities : viewModel.inventoryRarities) { rarity in
            BarMark(x: .value(Texts.ProfilePage.Stats.count,type == .research ? viewModel.rarityCount(for: rarity) : viewModel.inventoryRarityCount(for: rarity)),
                    
                    y: .value(Texts.ProfilePage.Stats.category, rarity.rawValue))
            
            .annotation(position: .trailing, alignment: .leading) {
                Text(String(type == .research ? viewModel.rarityCount(for: rarity) : viewModel.inventoryRarityCount(for: rarity)))
                
                    .padding(.leading)
            }
            .foregroundStyle(Rarity.rarityToColor(from: rarity))
            .opacity(0.8)
        }
        .padding()
        .chartLegend(.hidden)

    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        viewModel.addSamples()
        return StatsBarChartView(type: .research, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
