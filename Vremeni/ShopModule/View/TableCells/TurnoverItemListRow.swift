//
//  TurnoverItemListRow.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/25/24.
//

import SwiftUI

struct TurnoverItemListRow: View {
    private let item: ConsumableItem
    
    init(item: ConsumableItem) {
        self.item = item
    }
    
    internal var body: some View {
        HStack(spacing: 10) {
            (item.image.isEmpty ? Image.ShopPage.CreatePage.addImage : Image(systemName: item.image))
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .fontWeight(.light)
                .foregroundStyle(Color.LabelColors.labelSecondary, Color.LabelColors.labelDisable)
            
            VStack(alignment: .leading, spacing: 5) {
                name
                price
            }
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
    }
}

#Preview {
    let example = ConsumableItem(nameKey: "Item name", descriptionKey: "Item Description", image: "", price: 200, premium: true, profile: Profile.configMockProfile(), requirement: ["": 0], applications: ["": 0])
    return TurnoverItemListRow(item: example)
}
