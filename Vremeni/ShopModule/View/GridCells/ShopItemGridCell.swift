//
//  ShopItemGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI
import SwiftData

struct ShopItemGridCell: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var bannerService: BannerViewModel
    
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
    
    // MARK: - Item info block
    
    // ConsumableItem image
    private var itemImage: some View {
        Image(systemName: item.image)
            .resizable()
            .scaledToFit()
            .fontWeight(.light)
            .foregroundStyle(Color.accentColor, Color.cyan)
    }
    
    // ConsumableItem name & rarity icon
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
    
    // ConsumableItem price & vCoin icon
    private var priceView: some View {
        HStack(spacing: 5) {
            // vCoin icon
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            
            // Price value
            Text(String(Int(item.price)))
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
        }
    }
    
    // MARK: - Buttons block
    
    // Buttons for pickItem & archive viewModel methods
    private var buttons: some View {
        HStack(spacing: 5) {
            // Pick item button
            Button(action: {
                viewModel.pickItem(item: item)
                // Pick item banner
                bannerService.setBanner(banner: .added(message: Texts.Banner.added))
                // Medium haptic feedback
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }) {
                Text(Texts.ShopPage.addItem)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 40)
            .minimumScaleFactor(0.4)
            
            // Button layout params
            .foregroundStyle(Color.orange)
            .buttonStyle(.bordered)
            .tint(Color.orange)
            
            Spacer()
            
            // Archive item button
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.archiveItem(item: item)
                    // Archive item banner
                    bannerService.setBanner(banner: .archived(message: Texts.Banner.archived))
                }
                
            }) {
                Image(systemName: "archivebox")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            // Button layout params
            .frame(width: 40, height: 40)
            .padding(.trailing, 5)
            
            // Button style params
            .foregroundColor(Color.red)
            .buttonStyle(.bordered)
            .tint(Color.red)
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
        let environmentObject = BannerViewModel()
        let example = ConsumableItem.itemMockConfig(name: "One Hour", price: 1, profile: Profile.configMockProfile(), enabled: true)
        
        return ShopItemGridCell(item: example, viewModel: viewModel)
            .environmentObject(environmentObject)
    } catch {
        fatalError("Failed to create model container.")
    }
}
