//
//  ShopViewGridCellLocked.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/1/24.
//

import SwiftUI
import SwiftData

struct ShopViewGridCellLocked: View {
    
    private let item: ConsumableItem
    private var viewModel: ShopView.ShopViewModel
    
    init(item: ConsumableItem, viewModel: ShopView.ShopViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                itemInfo
                    .padding()
                    .frame(width: reader.size.width, alignment: .leading)
            }
            .background(Color.BackColors.backElevated)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 20)
        }
        .frame(height: 220)
    }
    
    private var itemInfo: some View {
        HStack(spacing: 16) {
            VStack(spacing: 10) {
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.light)
                    .foregroundStyle(Color.accentColor, Color.cyan)
                itemName
            }
            
            stats
                .frame(maxWidth: .infinity)
        }
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
        .lineLimit(1)
    }
    
    private var stats: some View {
        VStack {
            Text("Perfect Score")
                .lineLimit(1)
                .font(.ruleTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Text("The aspiration of any adequate person")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .font(.subhead())
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .padding(.top, -5)
            
            Spacer()
                        
            priceView
                .padding(.top, 5)
            
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.unlockItem(item: item)
                }
            }) {
                Text(Texts.ShopPage.research)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 40)
            .foregroundStyle(Color.orange)
            .minimumScaleFactor(0.4)
            .buttonStyle(.bordered)
            .tint(Color.orange)
            .padding(.top, 5)
            
        }
        .padding(.top, 10)
    }
    
    private var priceView: some View {
        HStack(spacing: 5) {
            Text("\(Texts.ItemCreatePage.price):")
                .font(.body())
            
            Text(String(Int(item.price)))
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
            
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(width: 17)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        let example = ConsumableItem.itemMockConfig(name: "One Hour", price: 1, enabled: false)
        return ShopViewGridCell(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
