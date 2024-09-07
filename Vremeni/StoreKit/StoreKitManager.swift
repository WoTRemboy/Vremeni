//
//  StoreKitManager.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 9/6/24.
//

import StoreKit

final class StoreKitManager: ObservableObject {
    @Published var products: [Product] = []
    
    init() {
        listenForTransactionUpdates()
    }
    
    internal func fetchProducts() async {
        do {
            let storeProducts = try await Product.products(for: ["Vremeni_Machine_Slot_Upgrade"])
            DispatchQueue.main.async {
                self.products = storeProducts
            }
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    internal func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        switch result {
        case .success(let verificationResult):
            switch verificationResult {
            case .verified(let transaction):
                await handlePurchase(transaction)
            case .unverified(_, let error):
                throw error
            }
        case .pending:
            print("Purchase pending...")
        case .userCancelled:
            print("User cancelled the purchase.")
        @unknown default:
            fatalError("Unknown purchase result.")
        }
    }
    
    private func handlePurchase(_ transaction: Transaction) async {
        await transaction.finish()
    }
    
    private func listenForTransactionUpdates() {
        Task {
            for await result in Transaction.updates {
                switch result {
                case .verified(let transaction):
                    await handlePurchase(transaction)
                case .unverified(_, let error):
                    print("Unverified transaction with error: \(error)")
                }
            }
        }
    }
}
