//
//  InventoryItemDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/10/24.
//

import SwiftUI
import SwiftData

struct InventoryItemDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    private let item: ConsumableItem
    private var viewModel: InventoryView.InventoryViewModel
    
    init(item: ConsumableItem, viewModel: InventoryView.InventoryViewModel) {
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
                    
                    TotalPrice(price: Float(item.count),
                               type: .count)
                        .padding(.top, 30)
                    
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
            
            ParameterRow(title: Texts.InventoryPage.valuation,
                         content: viewModel.valCalculation(for: item))
            
            ParameterRow(title: Texts.ItemCreatePage.applicationRules,
                         content: Texts.ItemCreatePage.null)
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = InventoryView.InventoryViewModel(modelContext: modelContext)
        
        let example = ConsumableItem.itemMockConfig(name: "One Minute", description: "One minute is a whole 60 seconds!", price: 50, rarity: .uncommon)
        return InventoryItemDetailsView(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
