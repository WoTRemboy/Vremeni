//
//  MachineView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct MachineView: View {
    
    @State private var viewModel: MachineViewModel
    private let spacing: CGFloat = 16
    private let itemsInRows = 1
    
    init(modelContext: ModelContext) {
        let viewModel = MachineViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                collection
                .padding(.horizontal)
            }
            .onAppear(perform: {
                viewModel.updateOnAppear()
            })
            
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackColors.backDefault)
        }
        .tabItem {
            Image.TabBar.machine
            Text(Texts.MachinePage.title)
        }
    }
    
    private var collection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            Section(header: sectionHeader) {
                if viewModel.items.filter({ $0.inProgress }).isEmpty {
                    EmptyMachineViewGridCell()
                }
                ForEach(viewModel.items) { item in
                    if item.inProgress {
                        MachineViewGridCell(item: item, viewModel: viewModel)
                    }
                }
                NewSlotMachineViewGridCell()
            }
            
            if !viewModel.items.filter({ $0.inMachine }).isEmpty {
                queueSection
            }
        }
    }
    
    private var queueSection: some View {
        Section(header: secondSectionHeader) {
            ForEach(viewModel.items) { item in
                if item.inMachine {
                    if item.percent != 0 {
                        MachineViewGridCell(item: item, paused: true, viewModel: viewModel)
                    } else {
                        QueueMachineViewGridCell(item: item, viewModel: viewModel)
                    }
                }
            }
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        return MachineView(modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
