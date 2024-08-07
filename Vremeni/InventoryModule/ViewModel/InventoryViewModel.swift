//
//  InventoryViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 29.07.2024.
//

import Foundation
import SwiftData

extension InventoryView {
    
    @Observable
    final class InventoryViewModel {
        
        private let modelContext: ModelContext
        private(set) var items = [ConsumableItem]()
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        internal func updateOnAppear() {
            fetchData()
        }
        
        private func fetchData() {
            do {
                let descriptor = FetchDescriptor<ConsumableItem>(predicate: #Predicate { $0.ready }, sortBy: [SortDescriptor(\.price)])
                items = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }

    }
}
