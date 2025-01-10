//
//  ArchiveDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/12/24.
//

import SwiftUI
import SwiftData

struct ArchiveDetailsView: View {
    
    private let item: ConsumableItem
    private var viewModel: ProfileView.ProfileViewModel
    private var onDismiss: () -> Void
        
    init(item: ConsumableItem,
         viewModel: ProfileView.ProfileViewModel,
         onDismiss: @escaping () -> Void) {
        self.item = item
        self.viewModel = viewModel
        self.onDismiss = onDismiss
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
                    restoreButton
                        .padding([.top, .horizontal])
                    
                    Spacer()
                }
            }
            .navigationTitle(Texts.ItemCreatePage.details)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        onDismiss()
                    }
                }
            }
        }
    }
    
    private var itemHead: some View {
        VStack(spacing: 5) {
            if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.buttonBorder)
                    .frame(width: 200)
            } else {
                Image.Placeholder.placeholder1to1
                    .resizable()
                    .scaledToFit()
                    .clipShape(.buttonBorder)
                    .frame(width: 200)
            }
            
            Text(item.name)
                .font(.segmentTitle())
                .padding(.top, 10)
            
            HStack(spacing: 5) {
                item.rarity.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text(item.rarity.name)
                    .font(.body())
            }
        }
    }
    
    private var params: some View {
        VStack(spacing: 14) {
            ParameterRow(title: Texts.ItemCreatePage.description,
                         content: item.itemDescription.isEmpty ? Texts.ItemCreatePage.null : item.itemDescription)
            
            ParameterRow(title: Texts.ItemCreatePage.research,
                         contentArray: viewModel.ruleDesctiption(item: item))
            
            ParameterRow(title: Texts.ItemCreatePage.application,
                         contentArray: viewModel.applicationDesctiption(item: item))
            
        }
    }
    
    private var restoreButton: some View {
        Button(action: {
            withAnimation(.snappy) {
                viewModel.unarchiveItem(item: item)
                onDismiss()
            }
        }) {
            Text(Texts.ProfilePage.Archive.restore)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 50)
        .minimumScaleFactor(0.4)
        
        .foregroundStyle(Color.green)
        .buttonStyle(.bordered)
        .tint(Color.green)
    }
}

// MARK: - Preview

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        
        let example = ConsumableItem.itemConfig(
            nameKey: Content.Common.oneMinuteTitle,
            descriptionKey: Content.Common.oneMinuteDescription,
            price: 50, rarity: .uncommon,
            profile: Profile.configMockProfile(),
            requirements: [],
            applications: [RuleItem.oneHour.rawValue : 1,
                           RuleItem.threeHours.rawValue : 3])
        return ArchiveDetailsView(item: example, viewModel: viewModel, onDismiss: {})
    } catch {
        fatalError("Failed to create model container.")
    }
}
