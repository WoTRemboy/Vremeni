//
//  MachineView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct MachineView: View {
    
    private let spacing: CGFloat = 16
    private let items = ConsumableItem.itemsMockConfig()
    private let itemsInRows = 1
    
    var body: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(items) { item in
                        MachineViewGridCell(item: item)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackColors.backDefault)
        }
        .tabItem {
            Image(systemName: "clock.arrow.2.circlepath")
            Text(Texts.MachinePage.title)
        }
    }
}

#Preview {
    MachineView()
}
