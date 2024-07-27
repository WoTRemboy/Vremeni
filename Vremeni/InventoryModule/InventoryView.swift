//
//  InventoryView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct InventoryView: View {
    var body: some View {
        Text(Texts.InventoryPage.title)
            .tabItem {
                Image.TabBar.inventory
                Text(Texts.InventoryPage.title)
            }
    }
}

#Preview {
    InventoryView()
}
