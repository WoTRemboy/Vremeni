//
//  ConsumableItemCreate.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/30/24.
//

import SwiftUI
import SwiftData

struct ConsumableItemCreate: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var item: ConsumableItem

    private var viewModel: ShopView.ShopViewModel
    
    init(viewModel: ShopView.ShopViewModel) {
        self.viewModel = viewModel
        self.item = ConsumableItem.itemMockConfig(name: String(), price: 1)
    }
    
    internal var body: some View {
        NavigationStack {
            Form {
                Section(Texts.ItemCreatePage.general) {
                    TextField(Texts.ItemCreatePage.name, text: $item.name)
                    TextField(Texts.ItemCreatePage.description, text: $item.itemDescription, axis: .vertical)
                }
                
                Section(Texts.ItemCreatePage.valuation) {
                    picker
                    Slider(value: $item.price, in: 1...50, step: 1)
                    totalPriceView
                }
                
                Section(Texts.ItemCreatePage.turnover) {
                    Text(Texts.ItemCreatePage.receiveRules)
                    Text(Texts.ItemCreatePage.applicationRules)
                }
            }
            .navigationTitle(Texts.ItemCreatePage.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Texts.ItemCreatePage.save) {
                        withAnimation(.snappy) {
                            viewModel.saveItem(item)
                            dismiss()
                        }
                    }
                    .disabled(item.name.isEmpty)
                }
            }
        }
    }
    
    private var totalPriceView: some View {
        HStack(spacing: 5) {
            Text(Texts.ItemCreatePage.total)
            
            Spacer()
            Text(String(Int(item.price)))
            Image.ShopPage.vCoin
                .resizable()
                .scaledToFit()
                .frame(width: 17)
        }
    }
    
    private var picker: some View {
        Picker(Texts.ItemCreatePage.rarity, selection: $item.rarity) {
            Text(Texts.Rarity.common).tag(Rarity.common)
            Text(Texts.Rarity.uncommon).tag(Rarity.uncommon)
            Text(Texts.Rarity.rare).tag(Rarity.rare)
            Text(Texts.Rarity.epic).tag(Rarity.epic)
            Text(Texts.Rarity.legendary).tag(Rarity.legendary)
            Text(Texts.Rarity.mythic).tag(Rarity.mythic)
            Text(Texts.Rarity.transcendent).tag(Rarity.transcendent)
            Text(Texts.Rarity.exotic).tag(Rarity.exotic)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        return ConsumableItemCreate(viewModel: viewModel)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}