//
//  InventoryItemDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/10/24.
//

import SwiftUI
import SwiftData

struct InventoryItemDetailsView: View {
    
    private let item: ConsumableItem
    private var viewModel: InventoryView.InventoryViewModel
    private var onDismiss: () -> Void
    
    init(item: ConsumableItem,
         viewModel: InventoryView.InventoryViewModel,
         onDismiss: @escaping () -> Void) {
        self.item = item
        self.viewModel = viewModel
        self.onDismiss = onDismiss
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
                        onDismiss()
                    }
                }
            }
        }
    }
    
    private var itemHead: some View {
        VStack(spacing: 5) {
            if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .clipShape(.buttonBorder)
                    .frame(width: 200, height: 200)
            } else {
                Image.Placeholder.placeholder1to1
                    .resizable()
                    .clipShape(.buttonBorder)
                    .frame(width: 200, height: 200)
            }
            
            
            Text(item.name)
                .font(.segmentTitle())
                .padding(.top, 10)
            
            HStack(spacing: 5) {
                item.rarity.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text(item.rarity.name)
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
            
            ParameterRow(title: Texts.ItemCreatePage.application,
                         contentArray: viewModel.applicationDesctiption(item: item))
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = InventoryView.InventoryViewModel(modelContext: modelContext)
        
        let example = ConsumableItem.itemMockConfig(
            nameKey: Content.Common.oneMinuteTitle,
            descriptionKey: Content.Common.oneMinuteDescription,
            price: 50, rarity: .uncommon,
            profile: Profile.configMockProfile())
        return InventoryItemDetailsView(item: example, viewModel: viewModel, onDismiss: {})
    } catch {
        fatalError("Failed to create model container.")
    }
}
