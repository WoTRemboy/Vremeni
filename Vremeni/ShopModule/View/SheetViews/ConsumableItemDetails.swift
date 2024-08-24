//
//  ConsumableItemDetails.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import SwiftUI
import SwiftData

struct ConsumableItemDetails: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var bannerService: BannerViewModel
    @Environment(\.dismiss) var dismiss
    
    private let item: ConsumableItem
    private var viewModel: ShopView.ShopViewModel
    
    // MARK: - Initialization
    
    init(item: ConsumableItem, viewModel: ShopView.ShopViewModel) {
        self.item = item
        self.viewModel = viewModel
    }
    
    // MARK: - Body view
    
    internal var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 5) {
                    // ConsumableItem image, name & rarity
                    itemHead
                    // ConsumableItem descriprion & rules rows
                    params
                        .padding(.top, 20)
                    // ConsumableItem price view
                    TotalPrice(price: item.price)
                        .padding(.top, 30)
                    // Enable context action button
                    buyButton
                        .padding([.top, .horizontal])
                    
                    Spacer()
                }
            }
            // Navigation bar params
            .navigationTitle(Texts.ItemCreatePage.details)
            .navigationBarTitleDisplayMode(.inline)
            
            // Navigation bar buttons
            .toolbar {
                // Dismiss button
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Support views
    
    // ConsumableItem image, name & rariry view
    private var itemHead: some View {
        VStack(spacing: 5) {
            // Item image
            Image(systemName: item.image)
                .resizable()
                .fontWeight(.light)
                .scaledToFit()
                .frame(width: 200)
                .foregroundStyle(Color.accentColor, Color.cyan)
            
            // Item name
            Text(item.name)
                .font(.segmentTitle())
                .padding(.top, 10)
            
            // Item rarity view
            HStack(spacing: 5) {
                // Rarity icon
                Rarity.rarityToImage(rarity: item.rarity)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                // Rarity name
                Text(item.rarity.rawValue)
                    .font(.body())
            }
        }
    }
    
    // ConsumableItem parameter rows
    private var params: some View {
        VStack(spacing: 14) {
            // Item description row
            ParameterRow(title: Texts.ItemCreatePage.description,
                         content: item.itemDescription.isEmpty ? Texts.ItemCreatePage.null : item.itemDescription)
            
            // Research rule name row
            ParameterRow(title: Texts.ItemCreatePage.receiveRules,
                         content: Texts.ItemCreatePage.null)
            
            // Application rule name row
            ParameterRow(title: Texts.ItemCreatePage.applicationRules,
                         content: Texts.ItemCreatePage.null)
            
        }
    }
    
    // Enable context action button
    private var buyButton: some View {
        Button(action: {
            if item.enabled {
                withAnimation(.snappy) {
                    // Pick item to machine when it is available
                    viewModel.pickItem(item: item)
                    bannerService.setBanner(banner: .added(message: Texts.Banner.added))
                }
            }
            dismiss()
        }) {
            // Button definition depending on enable status
            if item.enabled {
                Text(Texts.ShopPage.addToMachine)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                NavigationLink(destination: RuleView(item: item, viewModel: viewModel, details: true),
                               label: {
                    Text(Texts.ShopPage.research)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                })
            }
            
        }
        // Button layout params
        .frame(height: 50)
        .minimumScaleFactor(0.4)
        
        // Button style params
        .foregroundStyle(Color.orange)
        .buttonStyle(.bordered)
        .tint(Color.orange)
    }
}

// MARK: - Preview

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        let environmentObject = BannerViewModel()
        
        let example = ConsumableItem.itemMockConfig(name: "One Minute", description: "One minute is a whole 60 seconds!", price: 50, rarity: .uncommon, profile: Profile.configMockProfile())
        
        return ConsumableItemDetails(item: example, viewModel: viewModel)
            .environmentObject(environmentObject)
    } catch {
        fatalError("Failed to create model container.")
    }
}
