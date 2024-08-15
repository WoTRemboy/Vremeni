//
//  StatsPieChartView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/16/24.
//

import SwiftUI
import SwiftData
import Charts

struct StatsPieChartView: View {
    
    private var viewModel: ProfileView.ProfileViewModel
    
    private let spacing: CGFloat = 16
    private let itemsInRow = 3
        
    init(viewModel: ProfileView.ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        Chart(viewModel.actualRarities) { rarity in
            SectorMark(angle: .value(Texts.ProfilePage.count, viewModel.rarityCount(for: rarity)),
                       innerRadius: .ratio(0.6),
                       angularInset: 1.5)
            
            .cornerRadius(5)
            .foregroundStyle(Rarity.rarityToColor(from: rarity))
            .foregroundStyle(by: .value(Texts.ProfilePage.Stats.value, rarity.rawValue))
            .opacity(0.8)
        }
        .chartLegend(alignment: .center, spacing: 18) {
            legendGrid
        }
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                insideContent
                    .position(x: frame.midX, y: frame.midY)
            }
        }
        .frame(height: 400)
        .padding()
    }
    
    private var legendGrid: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRow)
        
        return LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(viewModel.actualRarities) { rarity in
                HStack {
                    BasicChartSymbolShape.circle
                        .foregroundColor(Rarity.rarityToColor(from: rarity))
                        .frame(width: 8, height: 8)
                    Text(rarity.rawValue)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
        }
    }
    
    private var insideContent: some View {
        VStack {
            Text(Texts.ProfilePage.unlocked)
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Text(String(viewModel.rarityCount(for: .all)))
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
        return StatsPieChartView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}