//
//  ShopViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI
import SwiftData

struct ShopViewGridCell: View {
    
    private let item: ConsumableItem
    private var viewModel: ShopView.ShopViewModel
    
    init(item: ConsumableItem, viewModel: ShopView.ShopViewModel) {
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
                priceView
                    .frame(width: reader.size.width, height: 17, alignment: .leading)
                buttons
                    .frame(width: reader.size.width, height: 40, alignment: .leading)
                    .padding(.top, 8)
            }
        }
        .frame(height: 280)
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
    
    private var priceView: some View {
        HStack(spacing: 5) {
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            
            Text(String(Int(item.price)))
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 5) {
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.pickItem(item: item)
                }
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }) {
                Text(item.enabled ? Texts.ShopPage.addItem : Texts.ShopPage.research)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 40)
            .foregroundStyle(Color.orange)
            .minimumScaleFactor(0.4)
            .buttonStyle(.bordered)
            .tint(Color.orange)
            
            Spacer()
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.deleteItem(item: item)
                }
            }) {
                Image(systemName: "archivebox")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 40, height: 40)
            .padding(.trailing, 5)
            .foregroundColor(Color.red)
            .buttonStyle(.bordered)
            .tint(Color.red)
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        let example = ConsumableItem.itemMockConfig(name: "One Hour", price: 1, enabled: true)
        return ShopViewGridCell(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
