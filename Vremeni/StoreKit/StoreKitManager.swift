//
//  StoreKitManager.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 9/6/24.
//

import StoreKit

typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

enum StoreError: Error {
    case failedVerification
}

final class StoreKitManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    
    @Published private(set) var subscriptions: [Product] = []
    @Published private(set) var purchasedSubscription: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    private let subscriptionsIDs = [SubscriptionType.annual.rawValue, SubscriptionType.monthly.rawValue]
    
    private var updateListenerTask: Task<Void, Error>? = nil
    
    init() {
        listenForTransactionUpdates()
        
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    internal func isPremiumNotPurchased() -> Bool {
        purchasedSubscription.isEmpty
    }
    
    @MainActor
    internal func requestProducts() async {
        do {
            subscriptions = try await Product.products(for: subscriptionsIDs)
        } catch {
            print("Failed product request from app store server: \(error)")
        }
    }
    
    internal func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            
            await updateCustomerProductStatus()
            await transaction.finish()
            
            print("Purchased: \(product.displayName)")
            return transaction
        case .pending:
            print("Purchase pending: \(product.displayName)")
            return nil
        case .userCancelled:
            print("Purchase cancelled: \(product.displayName)")
            return nil
        @unknown default:
            print("Unknown purchase status")
            return nil
        }
    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified(_, _):
            throw StoreError.failedVerification
        case .verified(let signedType):
            return signedType
        }
    }
    
    @MainActor
    private func updateCustomerProductStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                
                switch transaction.productType {
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscription.append(subscription)
                    }
                default:
                    break
                }
                
                await transaction.finish()
            } catch {
                print("Failed updating products")
            }
        }
    }
    
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    
                    await transaction.finish()
                } catch {
                    print("Transaction verification failed")
                }
            }
        }
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
    
    internal func restorePurchases() async throws {
        do {
            try await AppStore.sync()
        } catch {
            print(error)
        }
    }
    
    internal func purchaseUpgrade() async throws {
        guard let product = products.first else { return }
        
        do {
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
        } catch {
            print(error)
        }
    }
    
    private func handlePurchase(_ transaction: Transaction) async {
        await transaction.finish()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: .addSlotNotification, object: nil)
        }
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
