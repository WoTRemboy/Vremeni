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
    @State private var selected: ConsumableItem? = nil
    @State private var searchText = String()
    
    private let spacing: CGFloat = 16
    private let itemsInRows = 2
    
    init(modelContext: ModelContext) {
        let viewModel = InventoryViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    if searchText.isEmpty {
                        collection
                            .padding([.horizontal, .bottom])
                    } else {
                        isSearchingContent
                            .padding([.horizontal, .bottom])
                    }
                }
                .onAppear(perform: {
                    viewModel.updateOnAppear()
                })
                
                if viewModel.items.isEmpty {
                    placeholder
                } else if searchResults.isEmpty {
                    searchPlaceholder
                }
            }
            .scrollDisabled(viewModel.items.isEmpty)
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackColors.backDefault)
            .searchable(text: $searchText, prompt: Texts.ShopPage.searchItems)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    toolBarProgressView
                }
            }
        }
        .sheet(item: $selected) { item in
            InventoryItemDetailsView(item: item, viewModel: viewModel) {
                selected = nil
            }
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
                    Section(header: SectionHeader(rarity.name),
                            footer: InventoryStatsViewGridCell(rarity: rarity, viewModel: viewModel)) {
                        
                        ForEach(items) { item in
                            InventoryGridCell(item: item, viewModel: viewModel)
                                .onTapGesture {
                                    selected = item
                                }
                        }
                    }
                }
            }
        }
    }
    
    private var isSearchingContent: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            Section {
                ForEach(searchResults) { item in
                    InventoryGridCell(item: item, viewModel: viewModel)
                        .onTapGesture {
                            selected = item
                        }
                }
            } header: {
                if !searchResults.isEmpty {
                    SectionHeader(Texts.InventoryPage.result)
                }
            }
        }
    }
    
    private var toolBarProgressView: some View {
        Text(viewModel.progressItemsCount())
            .font(.headline())
            .foregroundStyle(Color.labelPrimary)
    }
    
    private var placeholder: some View {
        PlaceholderView(title: Texts.InventoryPage.placeholderTitle,
                        description: Texts.InventoryPage.placeholderSubtitle,
                        status: .inventory)
    }
    
    private var searchPlaceholder: some View {
        PlaceholderView(title: Texts.Placeholder.title,
                        description: "\(Texts.Placeholder.discription) “\(searchText)“",
                        status: .search)
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
