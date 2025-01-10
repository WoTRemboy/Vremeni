//
//  TabItems.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 1/10/25.
//

import SwiftUI
import SwiftData

struct TabItems {
    static internal func shopTab(modelContext: ModelContext) -> some View {
        ShopView(modelContext: modelContext)
            .tabItem {
                Image.TabBar.shop
                Text(Texts.ShopPage.title)
            }
    }
    
    static internal func machineTab(modelContext: ModelContext) -> some View {
        MachineView(modelContext: modelContext)
            .tabItem {
                Image.TabBar.machine
                Text(Texts.MachinePage.title)
            }
    }
    
    static internal func inventoryTab(modelContext: ModelContext) -> some View {
        InventoryView(modelContext: modelContext)
            .tabItem {
                Image.TabBar.inventory
                Text(Texts.InventoryPage.title)
            }
    }
    
    static internal func profileTab(modelContext: ModelContext) -> some View {
        ProfileView(modelContext: modelContext)
            .tabItem {
                Image.TabBar.profile
                Text(Texts.ProfilePage.title)
            }
    }
}
