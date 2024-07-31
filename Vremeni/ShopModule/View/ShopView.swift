//
//  ShopView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI
import SwiftData

struct ShopView: View {
    
    @State private var viewModel: ShopViewModel
    @State private var showingAddItemSheet = false
    @State private var selected: ConsumableItem? = nil
    
    private let spacing: CGFloat = 16
    private let itemsInRows = 2
    
    init(modelContext: ModelContext) {
        let viewModel = ShopViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    internal var body: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(viewModel.items) { item in
                            ShopViewGridCell(item: item, viewModel: viewModel)
                                .onTapGesture {
                                    selected = item
                                }
                        }
                        .sheet(item: $selected) { item in
                            ConsumableItemDetails(item: item, viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal)
                }
                
                .navigationTitle(Texts.Common.title)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.BackColors.backDefault)
                .toolbar {
                    Button(Texts.ShopPage.addItem, systemImage: "rectangle.stack.badge.plus") {
                        withAnimation(.snappy) {
                            viewModel.addSamples()
                        }
                    }
                    
                    Button(Texts.ShopPage.addItem, systemImage: "plus") {
                        showingAddItemSheet.toggle()
                    }
                    .sheet(isPresented: $showingAddItemSheet) {
                        ConsumableItemCreate(viewModel: viewModel)
                    }
                }
                
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
