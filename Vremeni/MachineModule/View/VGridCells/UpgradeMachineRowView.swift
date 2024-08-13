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
        HStack(spacing: 10) {
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
    }
    
    private var name: some View {
        HStack(spacing: 5) {
            Text(type.rawValue)
                .font(.body())
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
    }
    
    private var price: some View {
        HStack(spacing: 5) {
            switch type {
            case .coins:
                let price = viewModel.internalPrice
                Text(String(Int(price)))
                    .font(.headline())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                
                Image(.vCoin)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 17)
            case .money:
                let price = viewModel.donatePrice
                Text("$" + String(price))
                    .font(.headline())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
            }
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: MachineItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        return UpgradeMachineRowView(type: .money, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}