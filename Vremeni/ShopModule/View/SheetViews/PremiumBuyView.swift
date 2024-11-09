//
//  PremiumBuyView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/9/24.
//

import SwiftUI
import SwiftData

struct PremiumBuyView: View {
    
    @Environment(\.dismiss) private var dismiss
    private var viewModel: ShopView.ShopViewModel
    
    init(viewModel: ShopView.ShopViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Form {
                    imageTitleDesc
                    subscriprionButtons
                    includedLabels
                }
                .padding(.bottom, hasNotch() ? 100 : 80)
                actionButton
            }
            .edgesIgnoringSafeArea(.bottom)
            .scrollIndicators(.hidden)
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle(Texts.ShopPage.Premium.title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
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
    
    private var imageTitleDesc: some View {
        VStack {
            Image.ShopPage.Premium.logo
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.purple)
                .frame(height: 100)
                .padding(.top)
            
            Text(Texts.ShopPage.Premium.premium)
                .font(.subscriptionTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Text(Texts.ShopPage.Premium.description)
                .font(.subhead())
                .multilineTextAlignment(.center)
                .padding(.top, -5)
                .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity)
    }
    
    private var subscriprionButtons: some View {
        Section {
            Button {
                
            } label: {
                LinkRow(title: Texts.ShopPage.Premium.annual,
                        image: Image.ProfilePage.person,
                        details: viewModel.profile.name)
            }
            
            Button {
                
            } label: {
                LinkRow(title: Texts.ShopPage.Premium.monthly,
                        image: Image.ProfilePage.person,
                        details: viewModel.profile.name)
            }
        }
    }
    
    private var includedLabels: some View {
        Section(Texts.ShopPage.Premium.included) {
            LinkRow(title: Texts.ShopPage.Premium.contentTitle,
                    description: Texts.ShopPage.Premium.contentDescription,
                    image: Image.ShopPage.Premium.content)
            
            LinkRow(title: Texts.ShopPage.Premium.machineTitle,
                    description:  Texts.ShopPage.Premium.machineDescription,
                    image: Image.ShopPage.Premium.machine)
            
            LinkRow(title: Texts.ShopPage.Premium.constructorTitle,
                    description:  Texts.ShopPage.Premium.constructorContent,
                    image: Image.ShopPage.Premium.constructor)
        }
    }
    
    private var actionButton: some View {
        ZStack(alignment: hasNotch() ? .top : .center) {
            Rectangle()
                .fill(Color.BackColors.backiOSPrimary)
                .frame(maxWidth: .infinity, maxHeight: hasNotch() ? 100 : 80)
            
            Button {
               
            } label: {
                Text(Texts.ShopPage.Premium.subscribe)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .minimumScaleFactor(0.4)
            
            .foregroundStyle(Color.blue)
            .tint(Color.blue)
            .buttonStyle(.bordered)
            .padding()
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        return PremiumBuyView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
