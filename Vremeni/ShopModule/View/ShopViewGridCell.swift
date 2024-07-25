//
//  ShopViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI

struct ShopViewGridCell: View {
    
    private let item: ConsumableItem
    
    init(item: ConsumableItem) {
        self.item = item
    }
    
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 5) {
                itemImage
                    .frame(width: reader.size.width)
                itemName
                    .frame(width: reader.size.width, alignment: .leading)
                priceView
                    .frame(width: reader.size.width, height: 17, alignment: .leading)
            }
        }
        .frame(height: 220)
    }
    
    private var itemImage: some View {
        Image(systemName: item.image)
            .resizable()
            .scaledToFit()
            .fontWeight(.light)
            .foregroundStyle(Color.accentColor, Color.cyan)
    }
    
    private var itemName: some View {
        Text(item.name)
            .font(.body())
            .foregroundStyle(Color.labelPrimary)
    }
    
    private var priceView: some View {
        LazyHStack(spacing: 5) {
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(width: 17)
            
            Text(String(item.price))
                .font(.body())
                .foregroundStyle(Color.labelPrimary)
        }
    }
}

#Preview {
    ShopViewGridCell(item: ConsumableItem.itemMockConfig(name: "One Hour", price: 1))
}
