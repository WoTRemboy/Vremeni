//
//  BuyWorkshopView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/13/24.
//

import SwiftUI
import SwiftData

struct BuyWorkshopView: View {
    @EnvironmentObject private var storeKitService: StoreKitManager
    
    private let viewModel: MachineView.MachineViewModel
    private var onDismiss: () -> Void
    
    init(viewModel: MachineView.MachineViewModel,
         onDismiss: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onDismiss = onDismiss
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                options
                VStack(spacing: 10) {
                    restoreButton
                    buyButton
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .navigationTitle(Texts.MachinePage.Upgrade.upgrade)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        onDismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    topBarBalanceView
                }
            }
            .onAppear {
                guard let product = storeKitService.products.first else { return }
                viewModel.setPrice(for: product.displayPrice)
            }
        }
        .task {
            await storeKitService.fetchProducts()
        }
    }
    
    private var topBarBalanceView: some View {
        HStack(spacing: 5) {
            Image.ShopPage.vCoin
                .resizable()
                .scaledToFit()
                .frame(width: 17)
            
            Text(String(Int(viewModel.profile.balance)))
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
        }
    }
    
    private var options: some View {
        List {
            Button {
                viewModel.changePurchaseType(to: .coins)
            } label: {
                UpgradeMachineRowView(type: .coins, viewModel: viewModel)
            }

            Button {
                viewModel.changePurchaseType(to: .money)
            } label: {
                UpgradeMachineRowView(type: .money, viewModel: viewModel)
            }
        }
        .scrollDisabled(true)
    }
    
    private var restoreButton: some View {
        Button {
            Task {
                try await storeKitService.restorePurchases()
            }
        } label: {
            Text(Texts.MachinePage.Upgrade.restore)
        }
    }
    
    private var buyButton: some View {
        Button(action: {
            switch viewModel.selectedType {
            case .coins:
                withAnimation(.snappy) {
                    viewModel.slotPurchase(real: false)
                    onDismiss()
                }
            case .money:
                Task {
                    try await storeKitService.purchaseUpgrade()
                    onDismiss()
                }
            }
        }) {
            Text(Texts.MachinePage.Upgrade.purchase)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 50)
        .padding(.horizontal)
        .minimumScaleFactor(0.4)
        
        .foregroundStyle(Color.green)
        .buttonStyle(.bordered)
        .tint(Color.green)
        
        .disabled(viewModel.isPurchaseUnavailable())
        .animation(.easeInOut, value: viewModel.selectedType)
        .padding(.bottom)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        let enviromentObject = StoreKitManager()
        
        return BuyWorkshopView(viewModel: viewModel, onDismiss: {})
            .environmentObject(enviromentObject)
    } catch {
        fatalError("Failed to create model container.")
    }
}

