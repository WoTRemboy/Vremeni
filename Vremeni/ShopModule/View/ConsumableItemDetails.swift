//
//  ConsumableItemDetails.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import SwiftUI
import SwiftData

struct ConsumableItemDetails: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let item: ConsumableItem
    private var viewModel: ShopView.ShopViewModel
    
    init(item: ConsumableItem, viewModel: ShopView.ShopViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 5) {
                    itemHead
                    params
                        .padding(.top, 20)
                    
                    TotalPrice(price: item.price)
                        .padding(.top, 30)
                    
                    buyButton
                        .padding([.top, .horizontal])
                    
                    Spacer()
                }
            }
            .navigationTitle(Texts.ItemCreatePage.details)
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
    
    private var itemHead: some View {
        VStack(spacing: 5) {
            Image(systemName: item.image)
                .resizable()
                .fontWeight(.light)
                .scaledToFit()
                .frame(width: 200)
                .foregroundStyle(Color.accentColor, Color.cyan)
            
            Text(item.name)
                .font(.segmentTitle())
                .padding(.top, 10)
            
            HStack(spacing: 5) {
                Rarity.rarityToImage(rarity: item.rarity)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text(item.rarity.rawValue)
                    .font(.body())
            }
        }
    }
    
    private var params: some View {
        VStack(spacing: 14) {
            ParameterRow(title: Texts.ItemCreatePage.description,
                         content: item.itemDescription.isEmpty ? Texts.ItemCreatePage.null : item.itemDescription)
            
            
            ParameterRow(title: Texts.ItemCreatePage.receiveRules,
                         content: Texts.ItemCreatePage.null)
            
            ParameterRow(title: Texts.ItemCreatePage.applicationRules,
                         content: Texts.ItemCreatePage.null)
            
        }
    }
    
    private var buyButton: some View {
        Button(action: {
            withAnimation(.snappy) {
                if item.enabled {
                    viewModel.pickItem(item: item)
                } else {
                    viewModel.unlockItem(item: item)
                }
                dismiss()
            }
        }) {
            Text(item.enabled ? Texts.ShopPage.addToMachine : Texts.ShopPage.research)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 50)
        .foregroundStyle(Color.orange)
        .minimumScaleFactor(0.4)
        .buttonStyle(.bordered)
        .tint(Color.orange)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        let example = ConsumableItem.itemMockConfig(name: "One Minute", description: "One minute is a whole 60 seconds!", price: 50, rarity: .uncommon)
        return ConsumableItemDetails(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
