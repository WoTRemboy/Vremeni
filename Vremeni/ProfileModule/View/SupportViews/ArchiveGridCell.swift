//
//  ArchiveGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/12/24.
//

import SwiftUI
import SwiftData

struct ArchiveGridCell: View {
    
    private let item: ConsumableItem
    private var viewModel: ProfileView.ProfileViewModel
        
    init(item: ConsumableItem, viewModel: ProfileView.ProfileViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
        
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                content
                    .padding()
                    .frame(width: reader.size.width, alignment: .leading)
            }
            .background(Color.BackColors.backElevated)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 20)
        }
        .frame(height: 220)
    }
    
    
    private var content: some View {
        HStack(spacing: 16) {
            VStack(spacing: 10) {
                if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.buttonBorder)
                } else {
                    Image.Placeholder.placeholder1to1
                        .resizable()
                        .scaledToFit()
                        .clipShape(.buttonBorder)
                }
                itemRarity
            }
            
            itemInfo
                .frame(maxWidth: .infinity)
        }
    }
        
    private var itemRarity: some View {
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
        
    private var itemInfo: some View {
        VStack {
            Text(item.name)
                .lineLimit(1)
                .font(.ruleTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Text(item.itemDescription)
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
                    viewModel.unarchiveItem(item: item)
                }
            }) {
                Text(Texts.ProfilePage.Archive.restore)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 40)
            .minimumScaleFactor(0.4)
            .padding(.top, 5)
            
            .foregroundStyle(Color.green)
            .buttonStyle(.bordered)
            .tint(Color.green)
        }
        .padding(.top, 10)
    }
    
    private var priceView: some View {
        HStack(spacing: 5) {
            Text("\(Texts.ProfilePage.Archive.valuation):")
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
        
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        let example = ConsumableItem.itemMockConfig(
            nameKey: Content.Common.oneMinuteTitle,
            descriptionKey: Content.Common.oneMinuteDescription,
            price: 1, profile: Profile.configMockProfile(),
            enabled: false)
        return ArchiveGridCell(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}

