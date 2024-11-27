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
    @Binding var item: ConsumableItem
    
    private var viewModel: ShopView.ShopViewModel
    
    init(item: Binding<ConsumableItem>, viewModel: ShopView.ShopViewModel) {
        self._item = item
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            list
                .scrollIndicators(.hidden)
                .navigationTitle(Texts.ItemCreatePage.researchTitle)
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
            ForEach(viewModel.allItems) { requirement in
                Button(action: {
                    withAnimation(.snappy) {
                        item.addRequirement(item: requirement)
                        dismiss()
                    }
                }) {
                    TurnoverItemListRow(item: requirement)
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
        
        let example = ConsumableItem.itemMockConfig(nameKey: Content.Common.oneMinuteTitle, price: 1, profile: Profile.configMockProfile())
        
        return ConsumableItemAddView(item: .constant(example), viewModel: viewModel)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
