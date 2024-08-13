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
    @State private var selected: MachineItem? = nil
    @State private var showingAddItemList = false
    @State private var showingUpgradeSheet = false

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
                ForEach(viewModel.items) { item in
                    if item.inProgress {
                        MachineViewGridCell(item: item, viewModel: viewModel)
                            .onTapGesture {
                                selected = item
                            }
                            .sheet(item: $selected) { item in
                                MachineItemDetailsView(item: item, viewModel: viewModel)
                            }
                    }
                }
                
                VStack {
                    if viewModel.items.filter({ $0.inProgress }).isEmpty {
                        EmptyMachineViewGridCell()
                    } else if viewModel.isSlotAvailable() {
                        EmptyMachiveViewCompactCell()
                    }
                }
                .onTapGesture {
                    showingAddItemList.toggle()
                }
                .sheet(isPresented: $showingAddItemList, content: {
                    MachineAddItemsView(viewModel: viewModel)
                        .presentationDetents([.medium])
                })
                
                NewSlotMachineViewGridCell()
                    .onTapGesture {
                        showingUpgradeSheet.toggle()
                    }
                    .sheet(isPresented: $showingUpgradeSheet, content: {
                        BuyWorkshopView(viewModel: viewModel)
                            .presentationDetents([.medium])
                    })
            }
            
            if !viewModel.items.filter({ !$0.inProgress }).isEmpty {
                queueSection
            }
        }
    }
    
    private var queueSection: some View {
        Section(header: secondSectionHeader) {
            ForEach(viewModel.items) { item in
                if !item.inProgress {
                    if item.percent != 0 {
                        MachineViewGridCell(item: item, paused: true, viewModel: viewModel)
                            .onTapGesture {
                                selected = item
                            }
                            .sheet(item: $selected) { item in
                                MachineItemDetailsView(item: item, viewModel: viewModel)
                            }
                    } else {
                        QueueMachineViewGridCell(item: item, viewModel: viewModel)
                            .onTapGesture {
                                selected = item
                            }
                            .sheet(item: $selected) { item in
                                MachineItemDetailsView(item: item, viewModel: viewModel)
                            }
                    }
                }
            }
        }
    }
    
    private var sectionHeader: some View {
        SectionHeader(Texts.MachinePage.workshop)
    }
    
    private var secondSectionHeader: some View {
        SectionHeader(Texts.MachinePage.queue)
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
