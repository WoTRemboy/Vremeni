//
//  ConsumableItemAddView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/25/24.
//

import SwiftUI
import SwiftData

struct ConsumableItemAddView: View {
    @Environment(\.dismiss) var dismiss
    
    private var viewModel: ShopView.ShopViewModel
    
    init(viewModel: ShopView.ShopViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            list
                .scrollIndicators(.hidden)
                .navigationTitle(Texts.MachinePage.queue)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(Texts.ItemCreatePage.cancel) {
                            dismiss()
                        }
                    }
                }
        }
    }
    
    private var empty: some View {
        PlaceholderView(title: Texts.MachinePage.placeholderTitle,
                        description: Texts.MachinePage.placeholderSubtitle,
                        status: .machine)
    }
    
    private var background: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .foregroundStyle(Color.clear)
            .background(Color.BackColors.backiOSPrimary)
    }
    
    private var list: some View {
        List {
            ForEach(viewModel.allItems) { item in
                Button(action: {
                    withAnimation(.snappy) {
                        
                        dismiss()
                    }
                    
                }) {
//                        ItemListRow(item: item)
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        return ConsumableItemAddView(viewModel: viewModel)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
