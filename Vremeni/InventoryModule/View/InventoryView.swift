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
    
    private let spacing: CGFloat = 16
    private let itemsInRows = 1
    
    init(modelContext: ModelContext) {
        let viewModel = InventoryViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !viewModel.items.isEmpty {
                    List {
                        ForEach(viewModel.items) { item in
                            Text(item.name)
                        }
                    }
                } else {
                    Text(Texts.InventoryPage.placeholder)
                }
            }
            .onAppear(perform: {
                viewModel.updateOnAppear()
            })
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackColors.backDefault)
        }
        .tabItem {
            Image.TabBar.inventory
            Text(Texts.InventoryPage.title)
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
