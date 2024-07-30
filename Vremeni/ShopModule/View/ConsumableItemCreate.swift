//
//  ConsumableItemCreate.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/30/24.
//

import SwiftUI
import SwiftData

struct ConsumableItemCreate: View {
    
    @Bindable var item: ConsumableItem
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let example = ConsumableItem.itemMockConfig(name: "One Minute", price: 10)
        return ConsumableItemCreate(item: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
