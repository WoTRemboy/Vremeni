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
    
    @Namespace private var animation
    
    // ViewModel properties
    @State private var viewModel: ShopViewModel
    private let modelContext: ModelContext
    
    // Selected item to show & dismiss details sheet page
    @State private var selectedResearched: ConsumableItem? = nil
    @State private var selectedLocked: ConsumableItem? = nil
    @Environment(\.dismissSearch) private var dismissSearch
    
    // Show and dismiss add item sheet page
    @State private var showingAddItemSheet = false
    @State private var showingPremiumSheet = false
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
        NavigationStack {
            ZStack {
                content
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
            .animation(.easeInOut, value: searchText)
            
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
                ToolbarItem(placement: .topBarTrailing) {
                    toolBarButtonPremium
                }
            }
        }
        .sheet(isPresented: $showingPremiumSheet) {
            PremiumBuyView(viewModel: viewModel) {
                showingPremiumSheet.toggle()
            }
        }
        .sheet(isPresented: $showingAddItemSheet) {
            ConsumableItemCreate(viewModel: viewModel) {
                showingAddItemSheet.toggle()
            }
        }
        .sheet(item: $selectedResearched) { item in
            ConsumableItemDetails(
                item: item,
                viewModel: viewModel,
                namespace: animation) {
                    selectedResearched = nil
                }
        }
        // Item details sheet param
        .sheet(item: $selectedLocked) { item in
            ConsumableItemDetails(item: item,
                                  viewModel: viewModel,
                                  namespace: animation) {
                selectedLocked = nil
            }
        }
    }
    
    private var content: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                Section {
                    availableCollection
                        .padding([.horizontal, .bottom])
                } header: {
                    FilterScrollableView(viewModel: viewModel)
                }
            }
        }
    }
    
    // MARK: - Toolbar views
    
    private var toolBarButtonPremium: some View {
        Button {
            showingPremiumSheet.toggle()
        } label: {
            Image.ShopPage.premium
        }
    }
    
    private var toolBarButtonPlus: some View {
        Button {
            showingAddItemSheet.toggle()
        } label: {
            Image.ShopPage.plus
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
            let items = viewModel.enabledItems.filter({ $0.rarity == viewModel.selectedFilter })
            if !items.isEmpty {
                // Rarity Section for available Items
                Section {
                    ForEach(items) { item in
                        ShopItemGridCell(
                            item: item,
                            viewModel: viewModel,
                            namespace: animation)
                        .onTapGesture {
                            selectedResearched = item
                        }
                        .matchedTransitionSource(
                            id: "\(Texts.NavigationTransition.shopResearched)\(item.id)",
                            in: animation)
                    }
                }
            }
        }
    }
    
    private var researchCollection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: 1)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(Rarity.allCases) { rarity in
                let items = viewModel.lockedItems.filter({ $0.rarity == rarity })
                if !items.isEmpty {
                    // Rarity Section for locked Items
                    Section(header: SectionHeader(rarity.name)) {
                        ForEach(items) { item in
                            ShopItemGridCellLocked(item: item, viewModel: viewModel)
                                .onTapGesture {
                                    selectedLocked = item
                                }
                        }
                    }
                }
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
