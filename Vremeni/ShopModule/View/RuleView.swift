//
//  RuleView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/24/24.
//

import SwiftUI
import SwiftData

struct RuleView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    
    private var viewModel: ShopView.ShopViewModel
    private let item: ConsumableItem
    private let fromDetails: Bool
    
    init(item: ConsumableItem, viewModel: ShopView.ShopViewModel, details: Bool = false) {
        self.item = item
        self.viewModel = viewModel
        self.fromDetails = details
    }
    
    internal var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                unlockSection
                itemInfoNew
                researchCondition
                conditionRows
                button
            }
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle(Texts.ShopPage.Rule.title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    !fromDetails ? cancelButton : nil
                }
            }
        }
    }
    
    private var cancelButton: some View {
        Button(Texts.ItemCreatePage.cancel) {
            dismiss()
        }
        .foregroundStyle(Color.blue)
    }
    
    private var unlockSection: some View {
        SectionHeader(Texts.ShopPage.Rule.reward)
            .padding(.horizontal)
    }
    
    private var itemInfoNew: some View {
        HStack(spacing: 10) {
            Image(systemName: item.image)
                .resizable()
                .fontWeight(.light)
                .frame(width: 80, height: 80)
                .clipShape(.buttonBorder)
                .padding(.leading, -2.5)
                .foregroundStyle(Color.blue, Color.cyan)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.title())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                
                rarityRow
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var rarityRow: some View {
        HStack(spacing: 5) {
            item.rarity.image
                .resizable()
                .scaledToFit()
                .frame(height: 17)
            
            Text(item.rarity.name)
                .font(.subhead())
                .foregroundStyle(Color.LabelColors.labelSecondary)
        }
    }
    
    private var researchCondition: some View {
        SectionHeader(Texts.ShopPage.Rule.section)
            .padding([.top, .horizontal])
    }
    
    private var conditionRows: some View {
        VStack(spacing: 14) {
            ParameterRow(title: "One Minute",
                         content: "\(Texts.ShopPage.Rule.inventory): 5",
                         trailingContent: "3/3")
            ParameterRow(title: "Three Minutes",
                         content: "\(Texts.ShopPage.Rule.inventory): 2",
                         trailingContent: "2/6")
            ParameterRow(title: Texts.ShopPage.Rule.coins,
                         content: "\(Texts.ShopPage.Rule.inventory): 128",
                         trailingContent: "21/21")
        }
    }
    
    private var button: some View {
        Button(action: {
            showingAlert = true
        }) {
            Text(Texts.ShopPage.Rule.unlock)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(Texts.ShopPage.Rule.soon),
                  message: Text(Texts.ShopPage.Rule.working),
                  dismissButton: .cancel(Text(Texts.ShopPage.Rule.ok), action: {
                dismiss()
            }))
        }
        
        .frame(height: 50)
        .minimumScaleFactor(0.4)
        
        .foregroundStyle(Color.orange)
        .buttonStyle(.bordered)
        .tint(Color.orange)
        
        .padding(.horizontal)
        .padding(.vertical, 30)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        let example = ConsumableItem.itemMockConfig(
            nameKey: Content.Uncommon.fiveMinutesTitle,
            descriptionKey: Content.Uncommon.fiveMinutesDescription,
            price: 5, rarity: .uncommon,
            profile: Profile.configMockProfile())
        
        return RuleView(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
