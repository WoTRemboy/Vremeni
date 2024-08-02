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
    
    private let spacing: CGFloat = 16
    
    init(modelContext: ModelContext) {
        let viewModel = ShopViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    internal var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    ScrollView {
                        picker
                            .padding(.horizontal)
                        collection
                            .padding(.horizontal)
                            .padding(.top, 8)
                    }
                    if viewModel.items.isEmpty {
                        Text(Texts.ShopPage.placeholder)
                    }
                }
                
                .scrollDismissesKeyboard(.immediately)
                .navigationTitle(Texts.Common.title)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.BackColors.backDefault)
                .toolbar {
                    toolBarButtonSamples
                    toolBarButtonPlus
                }
                .searchable(text: $searchText, prompt: Texts.ShopPage.searchItems)
            }
            .tabItem {
                Image.TabBar.shop
                Text(Texts.ShopPage.title)
            }
            MachineView()
            InventoryView()
            ProfileView()
        }
    }
    
    private var toolBarButtonSamples: some View {
        Button(Texts.ShopPage.addItem, systemImage: "rectangle.stack.badge.plus") {
            withAnimation(.snappy) {
                viewModel.addSamples()
            }
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
    
    private var picker: some View {
        Picker(Texts.ShopPage.status, selection: $viewModel.enableStatus) {
            Text(Texts.ShopPage.available).tag(true)
            Text(Texts.ShopPage.locked).tag(false)
        }
        .pickerStyle(.segmented)
    }
    
    private var collection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(searchResults) { item in
                if item.enabled {
                    ShopViewGridCell(item: item, viewModel: viewModel)
                        .onAppear(perform: {
                            itemsInRows = 2
                        })
                        .onTapGesture {
                            selected = item
                        }
                } else {
                    ShopViewGridCellLocked(item: item)
                        .onAppear(perform: {
                            itemsInRows = 1
                        })
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
    
    private var searchResults: [ConsumableItem] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter { $0.name.contains(searchText) }
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
