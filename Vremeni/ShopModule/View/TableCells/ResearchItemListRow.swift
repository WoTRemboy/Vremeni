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
    private let requirement: Requirement
    
    init(item: ConsumableItem, requirement: Requirement) {
        self.item = item
        self.requirement = requirement
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
            Text(requirement.item.name)
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
            item.reduceRequirement(requirement: requirement)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    animateChange = false
                }
            }
            
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        } label: {
            Image.ShopPage.CreatePage.reduceRequirement
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .foregroundStyle(Color.white, Color.IconColors.blue)
        }
        .buttonStyle(.plain)
    }

    private var countLabel: some View {
        Text(String(requirement.quantity))
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
            item.addRequirement(item: requirement.item)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    animateChange = false
                }
            }
            
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        } label: {
            Image.ShopPage.CreatePage.addRequirement
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .foregroundStyle(Color.white, Color.IconColors.blue)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let requirementItem = ConsumableItem(nameKey: "Requirement", descriptionKey: "Requirement Description", image: "", price: 200, premium: true, profile: Profile.configMockProfile(), requirements: [], applications: ["": 0])
    let requirement = Requirement(item: requirementItem, quantity: 1)
    
    let example = ConsumableItem(nameKey: "Item name", descriptionKey: "Item Description", image: "", price: 200, premium: true, profile: Profile.configMockProfile(), requirements: [requirement], applications: ["": 0])
    
    ResearchItemListRow(item: example, requirement: requirement)
}
