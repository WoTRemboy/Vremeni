//
//  ShopView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI
import SwiftData

struct ShopView: View {
    
    // MARK: - Properties
    
    // ViewModel properties
    @State private var viewModel: ShopViewModel
    private let modelContext: ModelContext
    
    // Selected item to show & dismiss details sheet page
    @State private var selected: ConsumableItem? = nil
    @Environment(\.dismissSearch) private var dismissSearch
    
    // Show and dismiss add item sheet page
    @State private var showingAddItemSheet = false
    // Search bar result property
    @State private var searchText = String()
    
    // VGrid item space & count in a row
    private let spacing: CGFloat = 16
    @State private var itemsInRows = 2
    
    // MARK: - Initialization
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let viewModel = ShopViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    // MARK: - Body view
    
    internal var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    ScrollView {
                        enableSegmentedPicker
                            .padding(.horizontal)
                        if viewModel.enableStatus {
                            // Collecion with available items
                            availableCollection
                                .padding([.horizontal, .bottom])
                                .padding(.top, 8)
                                .transition(.move(edge: .leading))
                        } else {
                            // Collecion with locked items
                            researchCollection
                                .padding([.horizontal, .bottom])
                                .padding(.top, 8)
                                .transition(.move(edge: .trailing))
                        }
                    }
                    .onAppear {
                        viewModel.updateOnAppear()
                    }
                    // In case of items absence
                    if viewModel.items.isEmpty {
                        placeholder
                            .frame(maxWidth: .infinity, alignment: .center)
                        // No available <-, but No Locked ->
                            .transition(.move(edge: viewModel.enableStatus ? .leading : .trailing))
                    } else if searchResults.isEmpty {
                        searchPlaceholder
                    }
                }
                .animation(.easeInOut, value: viewModel.enableStatus)
                // ScrollView params
                .scrollDisabled(viewModel.items.isEmpty)
                .scrollDismissesKeyboard(.immediately)
                .background(Color.BackColors.backDefault)
                
                // Navigation title params
                .navigationTitle(Texts.Common.title)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, prompt: Texts.ShopPage.searchItems)
                
                // ToolBar items
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        toolBarMenuFilter
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        toolBarButtonPlus
                    }
                }
                .toolbarBackground(.visible, for: .tabBar)
                
            }
            // TabBar params & navigation
            .tabItem {
                Image.TabBar.shop
                Text(Texts.ShopPage.title)
            }
            MachineView(modelContext: modelContext)
            InventoryView(modelContext: modelContext)
            ProfileView(modelContext: modelContext)
        }
    }
    
    // MARK: - Toolbar views
    
    private var toolBarButtonPlus: some View {
        Button(Texts.ShopPage.addItem, systemImage: "plus") {
            showingAddItemSheet.toggle()
        }
        .sheet(isPresented: $showingAddItemSheet) {
            ConsumableItemCreate(viewModel: viewModel)
        }
    }
    
    private var toolBarMenuFilter: some View {
        // Menu with two pickers to display Sections
        Menu {
            // .all rarity case
            Picker(Texts.ShopPage.filterItems, selection: $viewModel.rarityFilter) {
                Text(Rarity.all.name)
                    .tag(Rarity.all)
            }
            Section {
                // Other rarity case
                Picker(Texts.ShopPage.filterItems, selection: $viewModel.rarityFilter) {
                    ForEach(Rarity.allCases) { rarity in
                        // Shows label only when there are items
                        if !viewModel.filterItems(for: rarity).isEmpty {
                            Label(
                                title: { Text(rarity.name) },
                                icon: { rarity.image }
                            )
                            .tag(rarity)
                        }
                    }
                }
            }
        } label: {
            // Image filling to demonstrate filter activity
            viewModel.rarityFilter == .all ? Image.ShopPage.filter : Image.ShopPage.filledFilter
        }
    }
    
    // MARK: - Content views
    
    // Available/Locked items picker (changes enabledStatus)
    private var enableSegmentedPicker: some View {
        Picker(Texts.ShopPage.status, selection: $viewModel.enableStatus.animation()) {
            Text(Texts.ShopPage.available).tag(true)
            Text(Texts.ShopPage.locked).tag(false)
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.enableStatus) {
            // Changes items count in a row
            itemsInRows = viewModel.changeRowItems(enabled: viewModel.enableStatus)
        }
    }
    
    private var availableCollection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: 2)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(searchResults.filter { $0.enabled }) { item in
                // Available item cell
                ShopItemGridCell(item: item, viewModel: viewModel)
                    .onTapGesture {
                        selected = item
                    }
            }
            // Item details sheet param
            .sheet(item: $selected) { item in
                ConsumableItemDetails(item: item, viewModel: viewModel)
            }
        }
    }
    
    private var researchCollection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: 1)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(searchResults) { item in
                ShopItemGridCellLocked(item: item, viewModel: viewModel)
                    .onTapGesture {
                        selected = item
                    }
            }
            // Item details sheet param
            .sheet(item: $selected) { item in
                ConsumableItemDetails(item: item, viewModel: viewModel)
            }
        }
    }
    
    // MARK: - Empty status views
    
    private var placeholder: some View {
        if viewModel.enableStatus {
            // No available items
            PlaceholderView(title: Texts.ShopPage.placeholderTitle,
                            description: Texts.ShopPage.placeholderSubtitle,
                            status: .unlocked)
        } else {
            // No locked items
            PlaceholderView(title: Texts.ShopPage.placeholderTitleLocked,
                            description: Texts.ShopPage.placeholderSubtitleLocked,
                            status: .locked)
        }
    }
    
    private var searchPlaceholder: some View {
        PlaceholderView(title: Texts.Placeholder.title,
                        description: "\(Texts.Placeholder.discription) “\(searchText)“",
                        status: .search)
    }
    
    // MARK: - Property for search bar results
    
    private var searchResults: [ConsumableItem] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            // Unfiltered to show results regardless of rarity
            return viewModel.unfilteredItems.filter { $0.name.contains(searchText) }
        }
    }
}

// MARK: - Preview

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
