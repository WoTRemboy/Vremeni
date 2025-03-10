//
//  QueueMachineViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/2/24.
//

import SwiftUI
import SwiftData

struct QueueMachineViewGridCell: View {
    
    private let item: MachineItem
    private let viewModel: MachineView.MachineViewModel
    
    init(item: MachineItem, viewModel: MachineView.MachineViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    internal var body: some View {
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
                if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.buttonBorder)
                } else {
                    Image.Placeholder.placeholder1to1
                        .resizable()
                        .scaledToFit()
                        .clipShape(.buttonBorder)
                }
                itemImageName
            }
            
            stats
                .frame(maxWidth: .infinity)
        }
    }
    
    private var itemImageName: some View {
        HStack(spacing: 5) {
            item.rarity.image
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            
            Text(item.rarity.name)
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
                .minimumScaleFactor(0.4)
            
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
            Text("\(Texts.MachinePage.reward):")
                .font(.body())
                .foregroundStyle(Color.labelPrimary)
            
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
        HStack(spacing: 16) {
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.setWorkshop(item: item)
                    if viewModel.notificationStatus == .allowed {
                        viewModel.notificationSetup(for: item)
                    }
                }
            }) {
                Image(systemName: "arrow.up")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 80, height: 40)
            .foregroundStyle(Color.green)
            .minimumScaleFactor(0.4)
            .buttonStyle(.bordered)
            .tint(Color.green)
            .disabled(!viewModel.processingItems.isEmpty && !viewModel.isSlotAvailable())
            
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.notificationRemove(for: item.id)
                    viewModel.deleteItem(item: item)
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
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        let example = MachineItem.itemMockConfig(name: "One Hour", description: "One hour is a whole 60 seconds!", price: 1, profile: Profile.configMockProfile())
        return QueueMachineViewGridCell(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}

