//
//  ResearchItemListRow.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/27/24.
//

import SwiftUI

struct ResearchItemListRow: View {
    
    @State private var animateChange = false
    
    private let item: ConsumableItem
    private let name: String
    private let count: Int
    
    init(item: ConsumableItem, name: String, count: Int) {
        self.item = item
        self.name = name
        self.count = count
    }
    
    internal var body: some View {
        HStack(spacing: 10) {
            nameLabel
            Spacer()
            minusCountPlus
        }
    }
    
    private var nameLabel: some View {
        HStack(spacing: 5) {
            Text(name)
                .font(.body())
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .lineLimit(1)
        }
    }
    
    private var minusCountPlus: some View {
        HStack(spacing: 16) {
            minusButton
            countLabel
            plusButton
        }
    }
    
    private var minusButton: some View {
        Button {
            withAnimation {
                animateChange = true
            }
            item.reduceRequirement(name: name)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    animateChange = false
                }
            }
        } label: {
            Image.ShopPage.CreatePage.reduceRequirement
                .resizable()
                .scaledToFit()
                .frame(width: 15)
                .foregroundStyle(Color.blue)
        }
        .buttonStyle(.plain)
    }

    private var countLabel: some View {
        Text(String(count))
            .font(.regularBody())
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .scaleEffect(animateChange ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: animateChange)
    }
    
    private var plusButton: some View {
        Button {
            withAnimation {
                animateChange = true
            }
            item.addRequirement(name: name)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    animateChange = false
                }
            }
        } label: {
            Image.ShopPage.CreatePage.addRequirement
                .resizable()
                .scaledToFit()
                .frame(height: 15)
                .foregroundStyle(Color.blue)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let example = ConsumableItem(nameKey: "Item name", descriptionKey: "Item Description", image: "", price: 200, premium: true, profile: Profile.configMockProfile(), requirement: ["": 0], applications: ["": 0])
    
    
    return ResearchItemListRow(item: example, name: "Requirement name", count: 0)
}
