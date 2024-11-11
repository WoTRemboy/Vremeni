//
//  ArchiveDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/12/24.
//

import SwiftUI
import SwiftData

struct ArchiveDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let item: ConsumableItem
    private var viewModel: ProfileView.ProfileViewModel
        
    init(item: ConsumableItem, viewModel: ProfileView.ProfileViewModel) {
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
            
            ParameterRow(title: Texts.ItemCreatePage.receiveRules,
                         contentArray: viewModel.ruleDesctiption(item: item))
            
            ParameterRow(title: Texts.ItemCreatePage.applicationRules,
                         contentArray: viewModel.applicationDesctiption(item: item))
            
        }
    }
    
    private var restoreButton: some View {
        Button(action: {
            withAnimation(.snappy) {
                viewModel.unarchiveItem(item: item)
                dismiss()
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
        
        let example = ConsumableItem.itemMockConfig(
            nameKey: Content.Common.oneMinuteTitle,
            descriptionKey: Content.Common.oneMinuteDescription,
            price: 50, rarity: .uncommon,
            profile: Profile.configMockProfile(),
            requirement: [RuleItem.oneHour.rawValue : 3],
            applications: [RuleItem.oneHour.rawValue : 1,
                           RuleItem.threeHours.rawValue : 3])
        return ArchiveDetailsView(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
