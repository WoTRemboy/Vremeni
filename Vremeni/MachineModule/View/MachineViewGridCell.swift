//
//  MachineViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct MachineViewGridCell: View {
    
    @StateObject private var viewModel = MachineViewModel()
    
    private let item: ConsumableItem
    private let updateInterval: TimeInterval = 1.0
    
    init(item: ConsumableItem) {
        self.item = item
    }
    
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                itemImage
                    .padding([.top, .leading])
                    .frame(width: reader.size.width, alignment: .leading)
                
                ProgressBar(width: reader.size.width - 32, percent: viewModel.percent)
                    .padding(.bottom)
                    .onAppear(perform: {
                        viewModel.startProgress(from: item.added, to: item.target)
                    })
                    .onDisappear(perform: {
                        viewModel.stopProgress()
                    })
            }
            .background(Color.BackColors.backElevated)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 20)
        }
        .frame(height: 220)
    }
    
    private var itemImage: some View {
        HStack(spacing: 16) {
            Image(systemName: item.image)
                .resizable()
                .scaledToFit()
                .fontWeight(.light)
                .foregroundStyle(Color.accentColor, Color.cyan)

            statsBlok
                .padding(.trailing)
        }
    }
    
    private var statsBlok: some View {
        LazyVStack(spacing: 10) {
            Text(item.name)
                .font(.title())
                .foregroundStyle(Color.labelPrimary)
            
            Text(item.added, formatter: Date.itemFormatter)
                .font(.subhead())
            Text(item.added.addingTimeInterval(TimeInterval(item.price * 3600)), formatter: Date.itemFormatter)
                .font(.subhead())
        }
    }
}

#Preview {
    MachineViewGridCell(item: ConsumableItem.itemMockConfig(name: "One", price: 1))
}
