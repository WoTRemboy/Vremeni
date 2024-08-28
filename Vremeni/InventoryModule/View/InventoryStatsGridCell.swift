//
//  InventoryStatsViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/9/24.
//

import SwiftUI
import SwiftData

struct InventoryStatsViewGridCell: View {
    
    private let rarity: Rarity
    private var viewModel: InventoryView.InventoryViewModel
    
    init(rarity: Rarity, viewModel: InventoryView.InventoryViewModel) {
        self.rarity = rarity
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                stats
                    .frame(width: reader.size.width, alignment: .center)
            }
            .frame(height: reader.size.height)
            .background(Color.BackColors.backDefault)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.Tints.orange, lineWidth: 4)
            )
        }
        .frame(height: 100)
    }
    
    private var stats: some View {
        HStack(spacing: 40) {
            Text(viewModel.rarityItemsCount(for: rarity))
                .font(.emptyCellTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            rarity.image
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            Text(viewModel.rarityItemsPercent(for: rarity))
                .font(.ruleTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = InventoryView.InventoryViewModel(modelContext: modelContext)
        return InventoryStatsViewGridCell(rarity: .common, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}

