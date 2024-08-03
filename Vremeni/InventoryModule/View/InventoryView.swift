//
//  InventoryView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct InventoryView: View {
    
    @Query(filter: #Predicate { $0.ready }, sort: \ConsumableItem.target) private var items: [ConsumableItem]
    
    private let spacing: CGFloat = 16
    private let itemsInRows = 1
    
    var body: some View {
//        let columns = Array(
//            repeating: GridItem(.flexible(), spacing: spacing),
//            count: itemsInRows)
        
        NavigationStack {
            ZStack {
//                ScrollView {
//                    LazyVGrid(columns: columns, spacing: spacing) {
//                        ForEach(items) { item in
//                            MachineViewGridCell(item: item)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
                
                if items.isEmpty {
                    Text(Texts.InventoryPage.placeholder)
                }
            }
            
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackColors.backDefault)
        }
        .tabItem {
            Image.TabBar.inventory
            Text(Texts.InventoryPage.title)
        }
    }
}

#Preview {
    InventoryView()
}
