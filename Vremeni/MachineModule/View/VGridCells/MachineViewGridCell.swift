//
//  MachineViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct MachineViewGridCell: View {
    
    private let item: ConsumableItem
    private let viewModel: MachineView.MachineViewModel
    
    init(item: ConsumableItem, viewModel: MachineView.MachineViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                itemImage
                    .padding([.top, .leading])
                    .frame(width: reader.size.width, alignment: .leading)
                
                ProgressBar(width: reader.size.width - 32,
                            percent: item.ready ? 100 : item.percent,
                            ready: item.ready)
                    .padding(.bottom)
                    .onAppear(perform: {
                        !item.ready ? viewModel.startProgress(for: item) : nil
                    })
                    .onDisappear(perform: {
                        !item.ready ? viewModel.stopProgress() : nil
                    })
            }
            .frame(height: reader.size.height)
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        let example = ConsumableItem.itemMockConfig(name: "One Hour", description: "One hour is a whole 60 seconds!", price: 1, rarity: .common, enabled: false)
        return MachineViewGridCell(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
