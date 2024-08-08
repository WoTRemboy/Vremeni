//
//  InventoryGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/7/24.
//

import SwiftUI
import SwiftData

struct InventoryGridCell: View {
    private let item: ConsumableItem
    private var viewModel: InventoryView.InventoryViewModel
    
    init(item: ConsumableItem, viewModel: InventoryView.InventoryViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 5) {
                itemImage
                    .frame(width: reader.size.width)
                itemName
                    .frame(width: reader.size.width, height: 25, alignment: .leading)
                countView
                    .frame(width: reader.size.width, height: 17, alignment: .leading)
            }
        }
        .frame(height: 230)
    }
    
    private var itemImage: some View {
        Image(systemName: item.image)
            .resizable()
            .scaledToFit()
            .fontWeight(.light)
            .foregroundStyle(Color.accentColor, Color.cyan)
    }
    
    private var itemName: some View {
        HStack(spacing: 5) {
            Rarity.rarityToImage(rarity: item.rarity)
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            
            Text(item.name)
                .font(.body())
                .foregroundStyle(Color.labelPrimary)
        }
    }
    
    private var countView: some View {
        HStack(spacing: 5) {
            Image.InventoryPage.count
                .resizable()
                .scaledToFit()
                .fontWeight(.heavy)
                .foregroundStyle(Color.white, Color.IconColors.blue)
                .frame(width: 25)
            
            Text(String(item.count))
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = InventoryView.InventoryViewModel(modelContext: modelContext)
        let example = ConsumableItem.itemMockConfig(name: "One Hour", price: 1, enabled: true)
        return InventoryGridCell(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
