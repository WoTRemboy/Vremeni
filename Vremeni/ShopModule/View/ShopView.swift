//
//  ShopView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI
import SwiftData

struct ShopView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ShopViewModel()
    
    private let spacing: CGFloat = 16
    private let itemsInRows = 2
    
    var body: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        TabView {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(viewModel.items) { item in
                            ShopViewGridCell(item: item)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        viewModel.pickItem(item: item, context: modelContext)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle(Texts.Common.title)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.BackColors.backDefault)
//                .toolbar {
//                    Button("Add Samples", systemImage: "plus") {
//
//                    }
//                }
                
            }
            .tabItem {
                Image.TabBar.shop
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
