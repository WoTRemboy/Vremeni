//
//  BuyWorkshopView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/13/24.
//

import SwiftUI
import SwiftData

struct BuyWorkshopView: View {
    @Environment(\.dismiss) var dismiss
    
    private let viewModel: MachineView.MachineViewModel
    
    init(viewModel: MachineView.MachineViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                options
                buyButton
            }
            .navigationTitle(Texts.MachinePage.upgrade)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    topBarBalanceView
                }
            }
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
    
    private var buyButton: some View {
        VStack {
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.slotPurchase()
                    dismiss()
                }
            }) {
                Text(Texts.MachinePage.purchase)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 50)
            .padding(.horizontal)
            .minimumScaleFactor(0.4)
            
            .foregroundStyle(Color.green)
            .buttonStyle(.bordered)
            .tint(Color.green)
            
            .disabled(viewModel.isPurchaseUnavailable())
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        
        return BuyWorkshopView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}

