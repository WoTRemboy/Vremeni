//
//  ItemListRow.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/5/24.
//

import SwiftUI

struct ItemListRow: View {
    private let item: MachineItem
    
    init(item: MachineItem) {
        self.item = item
    }
    
    internal var body: some View {
        HStack(spacing: 10) {
            Image(systemName: item.image)
                .resizable()
                .scaledToFit()
                .frame(height: 60)
                .fontWeight(.light)
                .foregroundStyle(Color.accentColor, Color.cyan)
                .padding(.leading, -6)
            
            VStack(alignment: .leading, spacing: 5) {
                name
                
                if item.percent != 0 {
                    progress
                } else {
                    price
                }
            }
        }
    }
    
    private var name: some View {
        HStack(spacing: 5) {
            Text(item.name)
                .font(.body())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
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
    
    private var progress: some View {
        Text("\(Int(item.percent))%")
            .font(.headline())
            .foregroundStyle(Color.labelPrimary)
    }
}

#Preview {
    let example = MachineItem(
        nameKey: "Item name",
        descriptionKey: "Item description",
        image: "8.square", price: 8,
        parent: ConsumableItem.itemMockConfig(
            nameKey: Content.Common.oneMinuteTitle,
            price: 1, profile: Profile.configMockProfile()))
    return ItemListRow(item: example)
}
