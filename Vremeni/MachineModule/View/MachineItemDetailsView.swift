//
//  MachineItemDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/5/24.
//

import SwiftUI
import SwiftData

struct MachineItemDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    private let item: MachineItem
    private var viewModel: MachineView.MachineViewModel
    
    init(item: MachineItem, viewModel: MachineView.MachineViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 5) {
                    itemHead
                    params
                        .padding(.top, 20)
                    
                    TotalPrice(price: item.price)
                        .padding(.top, 30)
                    
                    buyButton
                        .padding([.top, .horizontal])
                    
                    Spacer()
                }
            }
            .navigationTitle(Texts.ItemCreatePage.details)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var itemHead: some View {
        VStack(spacing: 5) {
            Image(systemName: item.image)
                .resizable()
                .fontWeight(.light)
                .scaledToFit()
                .frame(width: 200)
                .foregroundStyle(Color.accentColor, Color.cyan)
            
            Text(item.name)
                .font(.segmentTitle())
                .padding(.top, 10)
            
            HStack(spacing: 5) {
                Rarity.rarityToImage(rarity: item.rarity)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text(item.rarity.rawValue)
                    .font(.body())
            }
        }
    }
    
    private var params: some View {
        VStack(spacing: 14) {
            ParameterRow(title: Texts.ItemCreatePage.description,
                         content: item.itemDescription.isEmpty ? Texts.ItemCreatePage.null : item.itemDescription)
            
            if item.inProgress {
                ParameterRow(title: Texts.MachinePage.targetTime,
                             content: Date.itemFormatter.string(from: item.target))
            } else {
                ParameterRow(title: Texts.MachinePage.potentialTime,
                             content: viewModel.remainingTime(for: item))
            }
            
            ParameterRow(title: Texts.ItemCreatePage.applicationRules,
                         content: Texts.ItemCreatePage.null)
            
        }
    }
    
    private var buyButton: some View {
        Button(action: {
            withAnimation(.snappy) {
                if item.inProgress {
                    viewModel.progressDismiss(item: item)
                } else {
                    viewModel.setWorkshop(item: item)
                }
                dismiss()
            }
        }) {
            if item.inProgress {
                Text(Texts.MachinePage.pause)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                Text(item.percent != 0 ? Texts.MachinePage.continueProgress : Texts.MachinePage.start)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(height: 50)
        .foregroundStyle(item.percent != 0 ? Color.orange : Color.green)
        .minimumScaleFactor(0.4)
        .buttonStyle(.bordered)
        .tint(item.percent != 0 ? Color.orange : Color.green)
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
//        let modelContext = ModelContext(container)
//        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
//        
//        let example = ConsumableItem.itemMockConfig(name: "One Minute", description: "One minute is a whole 60 seconds!", price: 50, rarity: .uncommon)
//        return MachineItemDetailsView(item: example, viewModel: viewModel)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
