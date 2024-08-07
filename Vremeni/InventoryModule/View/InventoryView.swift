//
//  InventoryView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct InventoryView: View {
    
    @State private var viewModel: InventoryViewModel
    @State private var searchText = String()
    
    private let spacing: CGFloat = 16
    private let itemsInRows = 2
    
    init(modelContext: ModelContext) {
        let viewModel = InventoryViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                collection
                    .padding(.horizontal)
            }
            .onAppear(perform: {
                viewModel.updateOnAppear()
            })
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackColors.backDefault)
            .searchable(text: $searchText, prompt: Texts.ShopPage.searchItems)
        }
        .tabItem {
            Image.TabBar.inventory
            Text(Texts.InventoryPage.title)
        }
    }
    
    private var collection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(viewModel.items) { item in
                InventoryGridCell(item: item, viewModel: viewModel)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        return InventoryView(modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
