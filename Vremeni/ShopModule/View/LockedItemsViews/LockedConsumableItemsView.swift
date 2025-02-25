//
//  LockedConsumableItemsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 2/24/25.
//

import SwiftUI
import SwiftData

struct LockedConsumableItemsView: View {
    
    private var viewModel: ShopView.ShopViewModel
    private var onDismiss: () -> Void
    
    init(viewModel: ShopView.ShopViewModel,
         onDismiss: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onDismiss = onDismiss
    }
    
    internal var body: some View {
        NavigationStack {
            RarityCardsView()
            
            // Navigation title params
            .navigationTitle(Texts.ShopPage.Locked.title)
            .navigationBarTitleDisplayMode(.inline)
            
            .overlayPreferenceValue(
                RarityCardRectKey.self) { preferences in
                    if let cardPreference = preferences[Texts.PreferenceKey.cardRect] {
                        GeometryReader { proxy in
                            let cardRect = proxy[cardPreference]
                            cardsContent()
                                .frame(width: cardRect.width, height: cardRect.height)
                                .offset(x: cardRect.minX, y: cardRect.minY)
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private func cardsContent() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(Rarity.allCases) { rarity in
                    cardView(for: rarity)
                        .frame(height: 200)
                }
            }
        }
    }
    
    @ViewBuilder
    private func cardView(for rarity: Rarity) -> some View {
        GeometryReader { proxy in
            //let size = $0.size
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(rarity.color.gradient)
                    .overlay(alignment: .topLeading) {
                        overlayCellContent(for: rarity)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func overlayCellContent(for rarity: Rarity) -> some View {
        HStack(spacing: 0) {
            rarity.whiteImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            Text(rarity.name)
                .font(.system(size: 40, weight: .semibold))
                .foregroundStyle(Color.LabelColors.labelWhite)
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        return LockedConsumableItemsView(viewModel: viewModel, onDismiss: {})
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
