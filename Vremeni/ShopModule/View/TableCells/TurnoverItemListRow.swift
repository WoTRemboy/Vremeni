//
//  TurnoverItemListRow.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/25/24.
//

import SwiftUI

struct TurnoverItemListRow: View {
    private let item: ConsumableItem
    private let placeholder: Bool
    
    init(item: ConsumableItem, preview: Bool = false) {
        self.item = item
        self.placeholder = preview
    }
    
    internal var body: some View {
        HStack(spacing: 16) {
            if let image = item.image, let uiImage = UIImage(data: image) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(.buttonBorder)
            } else if placeholder {
                Image.ShopPage.CreatePage.addImage
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(.buttonBorder)
                    .fontWeight(.light)
                    .foregroundStyle(Color.LabelColors.labelSecondary, Color.LabelColors.labelDisable)
            } else {
                Image.Placeholder.placeholder1to1
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(.buttonBorder)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                name
                price
            }
            .animation(.easeInOut(duration: 0.2), value: item.name)
        }
    }
    
    private var name: some View {
        HStack(spacing: 5) {
            Text(item.name.isEmpty ? Texts.ItemCreatePage.itemName : item.name)
                .font(.body())
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .lineLimit(1)
            
            item.rarity.image
                .resizable()
                .scaledToFit()
                .frame(height: 17)
        }
    }
    
    private var price: some View {
        HStack(spacing: 5) {
            Text(String(Int(item.price)))
                .font(.headline())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(height: 17)
        }
        .animation(.easeInOut(duration: 0.1), value: item.price)
    }
}

#Preview {
    let example = ConsumableItem(nameKey: "Item name", descriptionKey: "Item Description", image: nil, price: 200, premium: true, profile: Profile.configMockProfile(), requirements: [], applications: ["": 0])
    
    return TurnoverItemListRow(item: example)
}
