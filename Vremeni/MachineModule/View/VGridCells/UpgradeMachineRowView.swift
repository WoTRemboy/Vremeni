//
//  UpgradeMachineRowView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/13/24.
//

import SwiftUI
import SwiftData

struct UpgradeMachineRowView: View {
    
    private(set) var viewModel: MachineView.MachineViewModel
    private let type: UpgrageMethod
    
    init(type: UpgrageMethod, viewModel: MachineView.MachineViewModel) {
        self.type = type
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        HStack {
            HStack(spacing: 16) {
                Image(systemName: type == .coins ? "v.square.fill" : "m.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                
                VStack(alignment: .leading, spacing: 5) {
                    name
                    price
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if type == viewModel.selectedType {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
    
    private var name: some View {
        HStack(spacing: 5) {
            Text(type.name)
                .font(.body())
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
    }
    
    private var price: some View {
        HStack {
            switch type {
            case .coins:
                if viewModel.slotLimitReached() {
                    limitPrice
                } else {
                    noLimitPrice
                }
                
            case .money:
                realCurrencyPrice
            }
            
        }
    }
    
    private var limitPrice: some View {
        let subtitle = Texts.MachinePage.Upgrade.limit
        return Text(subtitle)
            .font(.headline())
            .foregroundStyle(Color.LabelColors.labelPrimary)
    }
    
    private var noLimitPrice: some View {
        HStack(spacing: 5) {
            let price = viewModel.internalPrice
            let subtitle = String(Int(price))
            Text(subtitle)
                .font(.headline())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            Image(.vCoin)
                .resizable()
                .scaledToFit()
                .frame(height: 17)
        }
    }
    
    private var realCurrencyPrice: some View {
        Text(viewModel.price)
            .font(.headline())
            .foregroundStyle(Color.LabelColors.labelPrimary)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: MachineItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        return UpgradeMachineRowView(type: .coins, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
