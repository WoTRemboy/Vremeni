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
        self.item = ConsumableItem.itemMockConfig(name: String(), price: 1, enabled: false)
    }
    
    internal var body: some View {
        NavigationStack {
            form
                .scrollDismissesKeyboard(.immediately)
                .navigationTitle(Texts.ItemCreatePage.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        cancelButton
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        saveButton
                    }
                }
        }
    }
    
    private var cancelButton: some View {
        Button(Texts.ItemCreatePage.cancel) {
            dismiss()
        }
    }
    
    private var saveButton: some View {
        Button(Texts.ItemCreatePage.save) {
            withAnimation(.snappy) {
                viewModel.saveItem(item)
                dismiss()
            }
        }
        .disabled(item.name.isEmpty)
    }
    
    private var form: some View {
        Form {
            Section(Texts.ItemCreatePage.general) {
                TextField(Texts.ItemCreatePage.name, text: $item.name)
                TextField(Texts.ItemCreatePage.description, text: $item.itemDescription, axis: .vertical)
                Toggle(Texts.ShopPage.available, isOn: $item.enabled)
            }
            
            Section(Texts.ItemCreatePage.valuation) {
                picker
                totalPriceView
                Slider(value: $item.price, in: 1...50, step: 1)
            }
            
            Section(Texts.ItemCreatePage.turnover) {
                Text(Texts.ItemCreatePage.receiveRules)
                Text(Texts.ItemCreatePage.applicationRules)
            }
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
