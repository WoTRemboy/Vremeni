//
//  RootView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 1/10/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    internal var body: some View {
        TabView {
            TabItems.shopTab(modelContext: modelContext)
            TabItems.machineTab(modelContext: modelContext)
            TabItems.inventoryTab(modelContext: modelContext)
            TabItems.profileTab(modelContext: modelContext)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        return RootView(modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
