//
//  StatisticsChartView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/14/24.
//

import SwiftUI
import Charts
import SwiftData

struct StatisticsChartView: View {
    
    private var viewModel: ProfileView.ProfileViewModel
        
    init(viewModel: ProfileView.ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        chart
    }
    
    private var chart: some View {
        Chart(Rarity.allCases) { rarity in
            SectorMark(angle: .value(Texts.ProfilePage.count, viewModel.rarityCount(for: rarity)),
                       innerRadius: .ratio(0.6),
                       angularInset: 1.5)
            .cornerRadius(5)
            .foregroundStyle(rarity.color)
            .opacity(0.8)
        }
        .chartLegend(.hidden)
        .aspectRatio(1, contentMode: .fit)
        .frame(height: 250)
        
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                insideContent
                    .position(x: frame.midX, y: frame.midY)
            }
        }
    }
    
    private var insideContent: some View {
        VStack {
            Text(Texts.ProfilePage.unlocked)
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Text(String(viewModel.rarityCount(for: .common,
                                              allContent: true)))
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            Text("\(Texts.ProfilePage.total) \(viewModel.itemsCount)")
                .font(.callout)
                .foregroundStyle(.secondary)
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
        return StatisticsChartView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
