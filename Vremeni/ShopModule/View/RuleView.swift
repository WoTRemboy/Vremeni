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
                itemInfo
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
    
    private var itemInfo: some View {
        VStack(spacing: 5) {
            Image(systemName: item.image)
                .resizable()
                .fontWeight(.light)
                .scaledToFit()
                .frame(width: 200)
                .foregroundStyle(Color.blue, Color.cyan)
            
            Text(item.name)
                .font(.segmentTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .padding(.top, 10)
            
            HStack(spacing: 5) {
                Rarity.rarityToImage(rarity: item.rarity)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text(item.rarity.rawValue)
                    .font(.body())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
            }
        }
    }
    
    private var researchCondition: some View {
        SectionHeader(Texts.ShopPage.Rule.section)
            .padding(.horizontal)
            .padding(.top, 20)
    }
    
    private var conditionRows: some View {
        VStack(spacing: 14) {
            ParameterRow(title: "One Minute",
                         content: "Inventory: 5",
                         trailingContent: "3/3")
            ParameterRow(title: "Three Minutes",
                         content: "Inventory: 2",
                         trailingContent: "2/6")
            ParameterRow(title: "Coins",
                         content: "Inventory: 128",
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
        .padding(.top, 30)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        let example = ConsumableItem.itemMockConfig(name: "Five Minutes", description: "Five minutes is a whole 300 seconds!", price: 5, rarity: .uncommon, profile: Profile.configMockProfile())
        
        return RuleView(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
