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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    toolBarMenuFilter
                }
                ToolbarItem(placement: .topBarTrailing) {
                    toolBarBalanceView
                }
            }
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
            ForEach(Rarity.allCases) { rarity in
                let items = searchResults.filter({ $0.rarity == rarity })
                if !items.isEmpty {
                    Section(header: SectionHeader(rarity.rawValue),
                            footer: InventoryStatsViewGridCell(rarity: rarity, viewModel: viewModel)) {
                        
                        ForEach(items) { item in
                            InventoryGridCell(item: item, viewModel: viewModel)
                        }
                    }
                }
                
            }
        }
    }
    
    private var toolBarMenuFilter: some View {
        Menu {
            Picker(Texts.InventoryPage.filter, selection: $viewModel.rarityFilter) {
                Text(Rarity.all.rawValue)
                    .tag(Rarity.all)
            }
            Section {
                Picker(Texts.InventoryPage.filter, selection: $viewModel.rarityFilter) {
                    ForEach(Rarity.allCases) { rarity in
                        if !viewModel.filterItems(for: rarity).isEmpty {
                            Label(
                                title: { Text(rarity.rawValue) },
                                icon: { Rarity.rarityToImage(rarity: rarity) }
                            )
                            .tag(rarity)
                        }
                    }
                }
            }
        } label: {
            viewModel.rarityFilter == .all ? Image.ShopPage.filter : Image.ShopPage.filledFilter
        }
    }
    
    private var toolBarBalanceView: some View {
        HStack(spacing: 5) {
            Image.ShopPage.vCoin
                .resizable()
                .scaledToFit()
                .frame(width: 17)
            
            Text("128")
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
        }
    }
    
    private var searchResults: [ConsumableItem] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.unfilteredItems.filter { $0.name.contains(searchText) }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = InventoryView.InventoryViewModel(modelContext: modelContext)
        viewModel.addSamples()
        
        return InventoryView(modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
