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
    @State private var showingLockedSheet = false
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
                if viewModel.filteredResearchedItems.isEmpty {
                    placeholder
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if searchResults.isEmpty {
                    searchPlaceholder
                }
            }
            .overlay(alignment: .bottomTrailing) {
                floatingButton
            }
            .animation(.easeInOut, value: searchText)
            
            // ScrollView params
            .scrollDisabled(viewModel.filteredResearchedItems.isEmpty)
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
        .fullScreenCover(isPresented: $showingLockedSheet) {
            LockedConsumableItemsView(viewModel: viewModel) {
                showingLockedSheet.toggle()
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
    
    private var floatingButton: some View {
        Button {
            showingLockedSheet.toggle()
        } label: {
            Image.ShopPage.plusButton
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 2, y: 2)
        }
        .padding()
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
    
    private var availableCollection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: 2)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            let items = viewModel.filteredResearchedItems
            if !items.isEmpty {
                // Rarity Section for available Items
                ForEach(searchResults) { item in
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
    
    // MARK: - Empty status views
    
    private var placeholder: some View {
        if viewModel.filteredResearchedItems.isEmpty {
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
            return viewModel.filteredResearchedItems
        } else {
            return viewModel.filteredResearchedItems.filter { $0.name.contains(searchText) }
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
