//
//  ShopView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI

struct ShopView: View {
    
    let spacing: CGFloat = 16
    let items = ConsumableItem.itemsMockConfig()
    @State private var itemsInRows = 2
    
    var body: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(items) { item in
                            ShopViewGridCell(item: item)
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle(Texts.Common.title)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.BackColors.backDefault)
            }
            .tabItem {
                Image(systemName: "creditcard.and.123")
                Text(Texts.ShopPage.title)
            }
            MachineView()
            InventoryView()
            ProfileView()
        }
    }
}

#Preview {
    ShopView()
}
