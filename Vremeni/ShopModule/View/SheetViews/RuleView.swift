//
//  RuleView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/24/24.
//

import SwiftUI
import SwiftData

struct RuleView: View {
    
    @EnvironmentObject private var bannerService: BannerViewModel
    @Environment(\.dismiss) var dismiss
    
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
                itemInfoNew
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
        .padding([.top, .horizontal])
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
            ForEach(item.requirement.sorted(by: { $0.value > $1.value }), id: \.key) { requirement in
                ParameterRow(title: NSLocalizedString(requirement.key, comment: String()),
                             content: viewModel.researchContentSetup(for: requirement.key),
                             trailingContent: viewModel.researchTrailingSetup(for: requirement.key, of: requirement.value),
                             researchType: viewModel.researchTypeDefinition(for: requirement.key, of: requirement.value))
            }
            
            ParameterRow(title: Texts.ShopPage.Rule.coins,
                         content: "\(Texts.ShopPage.Rule.inventory): \(viewModel.profile.balance)",
                         trailingContent: "\(viewModel.profile.balance)/\(Int(item.price))",
                         researchType: viewModel.researchTypeDefinition(for: item.price))
        }
        .padding(.top)
    }
    
    private var button: some View {
        Button(action: {
            withAnimation(.snappy) {
                viewModel.unlockItem(item: item)
                bannerService.setBanner(banner: .unlocked(message: "\(Texts.Banner.unlocked): \(item.name)."))
                
                dismiss()
            }
        }) {
            Text(Texts.ShopPage.Rule.unlock)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .disabled(!viewModel.unlockButtonAvailable(for: item))
        
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
        
        let requirements = ["One Hour": 2, "Three Hours": 1]
        
        let example = ConsumableItem.itemMockConfig(
            nameKey: Content.Uncommon.fiveMinutesTitle,
            descriptionKey: Content.Uncommon.fiveMinutesDescription,
            price: 5, rarity: .uncommon,
            profile: Profile.configMockProfile(), requirement: requirements)
        
        return RuleView(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
