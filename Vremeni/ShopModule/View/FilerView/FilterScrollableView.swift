//
//  FilterScrollableView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 2/12/25.
//

import SwiftUI
import SwiftData

struct FilterScrollableView: View {
    @Namespace private var animation
    private var viewModel: ShopView.ShopViewModel
    
    init(viewModel: ShopView.ShopViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                scrollTabsContent(proxy: proxy)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func scrollTabsContent(proxy: ScrollViewProxy) -> some View {
        HStack(spacing: 8) {
            ForEach(Rarity.allCases, id: \.self) { rarity in
                FilterScrollableCell(
                    rarity: rarity,
                    selected: rarity.compareRarity(
                        for: viewModel.selectedFilter),
                    namespace: animation)
                .id(rarity)
                .onTapGesture {
                    viewModel.setFilter(to: rarity)
                    withAnimation {
                        proxy.scrollTo(rarity, anchor: .center)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        return FilterScrollableView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
