//
//  ConsumableItemCreate.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/30/24.
//

import SwiftUI
import SwiftData

struct ConsumableItemCreate: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) var dismiss
    @State private var item: ConsumableItem

    private var viewModel: ShopView.ShopViewModel
    
    // MARK: - Initialization
    
    init(viewModel: ShopView.ShopViewModel) {
        self.viewModel = viewModel
        self.item = ConsumableItem.itemMockConfig(
            nameKey: String(), price: 1,
            profile: viewModel.profile, enabled: false)
    }
    
    // MARK: - Body View
    
    internal var body: some View {
        NavigationStack {
            // main content form view
            form
                .scrollDismissesKeyboard(.immediately)
            
                // Navigation bar params
                .navigationTitle(Texts.ItemCreatePage.title)
                .navigationBarTitleDisplayMode(.inline)
            
                // ToolBar buttons
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
    
    // MARK: - ToolBar buttons
    
    // Dismiss button
    private var cancelButton: some View {
        Button(Texts.ItemCreatePage.cancel) {
            dismiss()
        }
    }
    
    // Button with save item action
    private var saveButton: some View {
        Button(Texts.ItemCreatePage.save) {
            withAnimation(.snappy) {
                viewModel.saveItem(item)
                dismiss()
            }
        }
        .disabled(item.name.isEmpty)
    }
    
    // MARK: - Content form view
    
    // Form with general, valuation & turnover sections
    private var form: some View {
        Form {
            // General Section
            Section(Texts.ItemCreatePage.general) {
                // Sets ConsumableItem name
                TextField(Texts.ItemCreatePage.name, text: $item.nameKey)
                // Sets ConsumableItem description
                TextField(Texts.ItemCreatePage.description, text: $item.descriptionKey, axis: .vertical)
                // Sets ConsumableItem enable status
                Toggle(Texts.ShopPage.available, isOn: $item.enabled)
            }
            
            // Valuation section
            Section(Texts.ItemCreatePage.valuation) {
                // Sets ConsumableItem rarity value
                picker
                // Displays ConsumableItem price value
                totalPriceView
                // Sets ConsumableItem price value
                Slider(value: $item.price, in: 1...1000, step: 1)
            }
            
            // Turnoiver section
            Section(Texts.ItemCreatePage.turnover) {
                // Displays research rules
                Text(Texts.ItemCreatePage.receiveRules)
                // Displays application rules
                Text(Texts.ItemCreatePage.applicationRules)
            }
        }
    }
    
    // MARK: - Valuation section support views
    
    // ConsumableItem rarity picker
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
    
    // ConsumableItem price value & vCoin icon
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

// MARK: - Preview

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
