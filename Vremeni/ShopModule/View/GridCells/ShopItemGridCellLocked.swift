//
//  ShopViewGridCellLocked.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/1/24.
//

import SwiftUI
import SwiftData

struct ShopItemGridCellLocked: View {
    
    // MARK: - Properties
    
    @State var selected: ConsumableItem? = nil

    private let item: ConsumableItem
    private var viewModel: ShopView.ShopViewModel
    
    // MARK: - Initialization
    
    init(item: ConsumableItem, viewModel: ShopView.ShopViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    // MARK: - Body view
    
    internal var body: some View {
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
    
    // MARK: - Content view
    
    private var itemInfo: some View {
        HStack(spacing: 16) {
            // ConsumableItem image, name & rarity icon
            VStack(spacing: 10) {
                if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(.buttonBorder)
                } else {
                    Image.Placeholder.placeholder1to1
                        .resizable()
                        .clipShape(.buttonBorder)
                }
                itemName
            }
            
            // Rule info, Consumable item price & research button
            stats
                .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - Left side view
    
    // ConsumableItem rarity name & icon
    private var itemName: some View {
        HStack(spacing: 5) {
            item.rarity.image
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            
            Text(item.rarity.name)
                .font(.body())
                .foregroundStyle(Color.labelPrimary)
        }
        .lineLimit(1)
    }
    
    // MARK: - Right side views
    
    // ConsumableItem name, desc, price & research button
    private var stats: some View {
        VStack {
            // ConsumableItem name
            Text(item.name)
                .lineLimit(1)
                .font(.ruleTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            // ConsumableItem description
            Text(item.itemDescription)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .font(.subhead())
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .padding(.top, -5)
            
            Spacer()
            
            // ConsumableItem price view
            priceView
                .padding(.top, 5)
            
            // Research button
            Button(action: {
                selected = item
            }) {
                Text(Texts.ShopPage.research)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .sheet(item: $selected) { item in
                if (item.premium && viewModel.premium) || !item.premium {
                    RuleView(item: item, viewModel: viewModel)
                } else {
                    PremiumBuyView(viewModel: viewModel)
                }
            }
            // Button layout params
            .frame(height: 40)
            .minimumScaleFactor(0.4)
            .padding(.top, 5)
            
            // Button style params
            .foregroundStyle(Color.orange)
            .buttonStyle(.bordered)
            .tint(Color.orange)
        }
        .padding(.top, 10)
    }
    
    // ConsumableItem price view
    private var priceView: some View {
        HStack(spacing: 5) {
            // Price label
            Text("\(Texts.ItemCreatePage.price):")
                .font(.body())
            
            // Price value
            Text(String(Int(item.price)))
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
            
            // vCoin icon
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(width: 17)
        }
    }
}

// MARK: - Preview

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        let example = ConsumableItem.itemMockConfig(
            nameKey: Content.Common.oneMinuteTitle,
            descriptionKey: Content.Common.oneMinuteDescription,
            price: 1, profile: Profile.configMockProfile(),
            enabled: false)
        return ShopItemGridCellLocked(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
