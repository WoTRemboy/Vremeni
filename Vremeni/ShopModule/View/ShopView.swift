//
//  ShopView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI
import SwiftData

struct ShopView: View {
    
    @Environment(\.dismissSearch) private var dismissSearch
    @State private var viewModel: ShopViewModel
    @State private var selected: ConsumableItem? = nil
    
    @State private var showingAddItemSheet = false
    @State private var searchText = String()
    @State private var itemsInRows = 2
    
    private let modelContext: ModelContext
    private let spacing: CGFloat = 16
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let viewModel = ShopViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    internal var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    ScrollView {
                        enableSegmentedPicker
                            .padding(.horizontal)
                        collection
                            .padding(.horizontal)
                            .padding(.top, 8)
                    }
                    if viewModel.items.isEmpty {
                        placeholder
                    }
                }
                .scrollDisabled(viewModel.items.isEmpty)
                .scrollDismissesKeyboard(.immediately)
                .navigationTitle(Texts.Common.title)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.BackColors.backDefault)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        toolBarMenuFilter
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        toolBarButtonPlus
                    }
                }
                .searchable(text: $searchText, prompt: Texts.ShopPage.searchItems)
            }
            .tabItem {
                Image.TabBar.shop
                Text(Texts.ShopPage.title)
            }
            MachineView(modelContext: modelContext)
            InventoryView(modelContext: modelContext)
            ProfileView()
        }
    }
    
    private var toolBarButtonPlus: some View {
        Button(Texts.ShopPage.addItem, systemImage: "plus") {
            showingAddItemSheet.toggle()
        }
        .sheet(isPresented: $showingAddItemSheet) {
            ConsumableItemCreate(viewModel: viewModel)
        }
    }
    
    private var toolBarMenuFilter: some View {
        Menu {
            Picker(Texts.ShopPage.filterItems, selection: $viewModel.rarityFilter) {
                Text(Rarity.all.rawValue)
                    .tag(Rarity.all)
            }
            Section {
                Picker(Texts.ShopPage.filterItems, selection: $viewModel.rarityFilter) {
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
    
    private var enableSegmentedPicker: some View {
        Picker(Texts.ShopPage.status, selection: $viewModel.enableStatus) {
            Text(Texts.ShopPage.available).tag(true)
            Text(Texts.ShopPage.locked).tag(false)
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.enableStatus) {
            itemsInRows = viewModel.changeRowItems(enabled: viewModel.enableStatus)
        }
    }
    
    private var collection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(searchResults) { item in
                if item.enabled {
                    ShopViewGridCell(item: item, viewModel: viewModel)
                        .onTapGesture {
                            selected = item
                        }
                } else {
                    ShopViewGridCellLocked(item: item, viewModel: viewModel)
                        .onTapGesture {
                            selected = item
                        }
                }
            }
            .sheet(item: $selected) { item in
                ConsumableItemDetails(item: item, viewModel: viewModel)
            }
        }
    }
    
    private var placeholder: some View {
        if viewModel.enableStatus {
            PlaceholderView(title: Texts.ShopPage.placeholderTitle,
                            description: Texts.ShopPage.placeholderSubtitle,
                            status: .unlocked)
        } else {
            PlaceholderView(title: Texts.ShopPage.placeholderTitleLocked,
                            description: Texts.ShopPage.placeholderSubtitleLocked,
                            status: .locked)
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
        return ShopView(modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
