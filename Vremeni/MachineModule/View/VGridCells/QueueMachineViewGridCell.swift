//
//  QueueMachineViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/2/24.
//

import SwiftUI

struct QueueMachineViewGridCell: View {
    private let item: ConsumableItem
    
    init(item: ConsumableItem) {
        self.item = item
    }
    
    var body: some View {
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
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.light)
                    .foregroundStyle(Color.accentColor, Color.cyan)
                itemImageName
            }
            
            stats
                .frame(maxWidth: .infinity)
        }
    }
    
    private var itemImageName: some View {
        HStack(spacing: 5) {
            Rarity.rarityToImage(rarity: item.rarity)
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            
            Text(item.rarity.rawValue)
                .font(.body())
                .foregroundStyle(Color.labelPrimary)
        }
        .lineLimit(1)
    }
    
    private var stats: some View {
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
            
            buttons
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
    
    private var buttons: some View {
        HStack {
            Button(action: {
                withAnimation(.snappy) {
//                    viewModel.deleteItem(item: item)
                }
            }) {
                Image(systemName: "trash")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 40, height: 40)
            .padding(.trailing, 5)
            .foregroundColor(Color.red)
            .buttonStyle(.bordered)
            .tint(Color.red)
            
            Button(action: {
                withAnimation(.snappy) {
//                    viewModel.pickItem(item: item)
                }
            }) {
                Image(systemName: "arrow.down")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 60, height: 40)
            .foregroundStyle(Color.orange)
            .minimumScaleFactor(0.4)
            .buttonStyle(.bordered)
            .tint(Color.orange)
            
            Button(action: {
                withAnimation(.snappy) {
//                    viewModel.pickItem(item: item)
                }
            }) {
                Image(systemName: "arrow.up")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 60, height: 40)
            .foregroundStyle(Color.green)
            .minimumScaleFactor(0.4)
            .buttonStyle(.bordered)
            .tint(Color.green)
        }
    }
}

#Preview {
    let example = ConsumableItem.itemMockConfig(name: "One Hour", description: "One hour is a whole 60 seconds!", price: 1, rarity: .common, enabled: false)
    return QueueMachineViewGridCell(item: example)
}

