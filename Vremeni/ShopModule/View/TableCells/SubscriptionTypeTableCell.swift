//
//  SubscriptionTypeTableCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/10/24.
//

import SwiftUI
import SwiftData

struct SubscriptionTypeTableCell: View {
    
    private let type: SubscriptionType
    private var viewModel: ShopView.ShopViewModel
    
    init(type: SubscriptionType, viewModel: ShopView.ShopViewModel) {
        self.type = type
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        HStack {
            leftLabel
            Spacer()
                Text("199,16 RUB/month")
                    .font(.regularBody())
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(Color.LabelColors.labelSecondary)
        }
    }
    
    private var leftLabel: some View {
        HStack(spacing: 16) {
            ZStack {
                if viewModel.currentSubType == type {
                    Image.ShopPage.Premium.check
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.white, Color.blue)
                        .transition(.scale)
                        .frame(width: 20)
                } else {
                    Image.ShopPage.Premium.uncheck
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.LabelColors.labelSecondary)
                        .transition(.scale)
                        .frame(width: 20)
                }
            }
            .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(type == .annual ? Texts.ShopPage.Premium.annual : Texts.ShopPage.Premium.monthly)
                    .font(.regularBody())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                
                if type == .annual {
                    HStack {
                        Text("3 947 RUB/year")
                            .font(.lightFootnote())
                            .foregroundStyle(Color.LabelColors.labelSecondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        return SubscriptionTypeTableCell(type: .annual, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
