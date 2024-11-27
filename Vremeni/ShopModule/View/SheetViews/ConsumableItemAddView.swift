//
//  ConsumableItemAddView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/25/24.
//

import SwiftUI
import SwiftData

struct ConsumableItemAddView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var item: ConsumableItem
    @State private var searchText = String()
    
    private var viewModel: ShopView.ShopViewModel
    
    init(item: Binding<ConsumableItem>, viewModel: ShopView.ShopViewModel) {
        self._item = item
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                list
                    .navigationTitle(Texts.ItemCreatePage.researchTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(Texts.ItemCreatePage.cancel) {
                                dismiss()
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            item.rarity.image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        }
                    }
                
                if searchResults.isEmpty {
                    searchPlaceholder
                }
            }
        }
        .searchable(text: $searchText.animation(.easeInOut), prompt: Texts.ShopPage.searchItems)
    }
    
    private var list: some View {
        List {
            ForEach(searchResults) { requirement in
                Button(action: {
                    withAnimation(.snappy) {
                        item.addRequirement(item: requirement)
                        dismiss()
                    }
                }) {
                    TurnoverItemListRow(item: requirement)
                }
            }
        }
        .animation(.easeInOut, value: searchText)
    }
    
    private var searchPlaceholder: some View {
        PlaceholderView(title: Texts.Placeholder.title,
                        description: "\(Texts.Placeholder.discription) “\(searchText)“",
                        status: .search)
    }
    
    private var searchResults: [ConsumableItem] {
        if searchText.isEmpty {
            return viewModel.allItems
        } else {
            return viewModel.allItems.filter { $0.name.contains(searchText) }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        let example = ConsumableItem.itemMockConfig(nameKey: Content.Common.oneMinuteTitle, price: 1, profile: Profile.configMockProfile())
        
        return ConsumableItemAddView(item: .constant(example), viewModel: viewModel)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
