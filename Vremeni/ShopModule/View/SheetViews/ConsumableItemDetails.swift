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
            if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
            } else {
                Image.Placeholder.placeholder1to1
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
            }
            
            // Item name
            Text(item.name)
                .font(.segmentTitle())
                .padding(.top, 10)
            
            // Item rarity view
            HStack(spacing: 5) {
                // Rarity icon
                item.rarity.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                // Rarity name
                Text(item.rarity.name)
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
            ParameterRow(title: Texts.ItemCreatePage.research,
                         contentArray: viewModel.ruleDesctiption(item: item))
            
            // Application rule name row
            ParameterRow(title: Texts.ItemCreatePage.application,
                         contentArray: viewModel.applicationDesctiption(item: item))
            
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
        
        let example = ConsumableItem.itemMockConfig(
            nameKey: Content.Common.threeMinutesTitle,
            descriptionKey: Content.Common.threeMinutesDescription,
            price: 3,
            rarity: .common,
            profile: Profile.configMockProfile(),
            requirements: [],
            applications: [RuleItem.oneHour.rawValue : 1,
                           RuleItem.threeHours.rawValue : 3],
            enabled: false)
        
        return ConsumableItemDetails(item: example, viewModel: viewModel)
            .environmentObject(environmentObject)
    } catch {
        fatalError("Failed to create model container.")
    }
}
