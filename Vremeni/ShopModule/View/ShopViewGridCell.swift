//
//  ShopViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI

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
            }
        }
        .frame(height: 260)
    }
    
    private var itemImage: some View {
        Image(systemName: item.image)
            .resizable()
            .scaledToFit()
            .fontWeight(.light)
            .foregroundStyle(Color.accentColor, Color.cyan)
    }
    
    private var itemName: some View {
        LazyHStack(spacing: 5) {
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
        LazyHStack(spacing: 5) {
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(width: 17)
                .padding(.leading, 3.8)
            
            Text(String(item.price))
                .font(.body())
                .foregroundStyle(Color.labelPrimary)
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 0) {
            Button(Texts.ShopPage.addToMachine) {
                withAnimation(.snappy) {
                    viewModel.pickItem(item: item)
                }
            }
            
            Spacer()
            Button(String(), systemImage: "trash") {
                withAnimation(.snappy) {
                    viewModel.deleteItem(item: item)
                }
            }
            .foregroundColor(Color.red)
        }
    }
}

//#Preview {
//    ShopViewGridCell(item: ConsumableItem.itemMockConfig(name: "One Hour", price: 1))
//}
