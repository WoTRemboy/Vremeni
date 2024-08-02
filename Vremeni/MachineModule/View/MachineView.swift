//
//  MachineView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct MachineView: View {
    
    @Query(filter: #Predicate { $0.inMachine }, sort: \ConsumableItem.started) var items: [ConsumableItem]
    
    private let spacing: CGFloat = 16
    private let itemsInRows = 1
    
    var body: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: spacing) {
                    Section(header: sectionHeader) {
                        if items.filter({ $0.inProgress }).isEmpty {
                            EmptyMachineViewGridCell()
                        }
                        ForEach(items.filter({ $0.inProgress })) { item in
                            MachineViewGridCell(item: item)
                        }
                        NewSlotMachineViewGridCell()
                    }
                    
                    if !items.filter({ $0.inMachine }).isEmpty {
                        Section(header: secondSectionHeader) {
                            ForEach(items.filter({ $0.inMachine })) { item in
                                QueueMachineViewGridCell(item: item)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackColors.backDefault)
        }
        .tabItem {
            Image.TabBar.machine
            Text(Texts.MachinePage.title)
        }
    }
    
    private var sectionHeader: some View {
        Text(Texts.MachinePage.workshop)
            .font(.segmentTitle())
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var secondSectionHeader: some View {
        Text(Texts.MachinePage.queue)
            .font(.segmentTitle())
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MachineView()
}
