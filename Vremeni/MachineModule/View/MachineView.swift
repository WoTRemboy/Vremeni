//
//  MachineView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct MachineView: View {
    
    // MARK: - Properties
    
    // Banner viewModel
    @EnvironmentObject var bannerService: BannerViewModel
    // Machine viewModel
    @State private var viewModel: MachineViewModel
    
    // Selected item for sheet display
    @State private var selected: MachineItem? = nil
    // Sheet display toggles
    @State private var showingAddItemList = false
    @State private var showingUpgradeSheet = false

    // Collection params
    private let spacing: CGFloat = 16
    private let itemsInRows = 1
    
    // MARK: - Initialization
    
    init(modelContext: ModelContext) {
        let viewModel = MachineViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    // MARK: - Body content
    
    internal var body: some View {
        NavigationStack {
            ScrollView {
                collection
                .padding(.horizontal)
            }
            // Collection view data update
            .onAppear(perform: {
                viewModel.updateOnAppear()
            })
            // Shows ready banner when item is ready
            .onChange(of: viewModel.readyNotification.ready) {
                guard let name = viewModel.readyNotification.name else { return }
                bannerService.setBanner(banner: .ready(message: "«\(name)» \(Texts.Banner.ready)"))
                viewModel.hideReadyNotification()
            }
            .background(Color.BackColors.backDefault)
            
            // Navigation bar params
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .tabItem {
            Image.TabBar.machine
            Text(Texts.MachinePage.title)
        }
    }
    
    // MARK: - Collection view
    
    private var collection: some View {
        // Collection view display params
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            // Workshop section
            Section(header: sectionHeader) {
                ForEach(viewModel.items) { item in
                    // In case item in workshop progress exists
                    if item.inProgress {
                        // MachineItem progress cell
                        MachineViewGridCell(item: item, viewModel: viewModel)
                            .onTapGesture {
                                selected = item
                            }
                            // Shows item progress details
                            .sheet(item: $selected) { item in
                                MachineItemDetailsView(item: item, viewModel: viewModel)
                            }
                    }
                }
                
                // Add new MachineItem to workshop (regular & compact vers)
                addNewItemCell
                
                // All workshop cell are busy
                if !viewModel.isSlotAvailable() {
                    // Upgrade workshop cell
                    upgradeCell
                }
            }
            
            // In case there are items in queue
            if !viewModel.items.filter({ !$0.inProgress }).isEmpty {
                queueSection
            }
        }
    }
    
    // MARK: - Workshop section cells
    
    private var addNewItemCell: some View {
        VStack {
            // Workshop is empty
            if viewModel.items.filter({ $0.inProgress }).isEmpty {
                // Regular cell
                EmptyMachineViewGridCell()
            // There is MachineItem in progress
            } else if viewModel.isSlotAvailable() {
                // Compact cell
                EmptyMachiveViewCompactCell()
                    .padding(.top)
            }
        }
        .onTapGesture {
            showingAddItemList.toggle()
        }
        // Shows Queue sheet menu
        .sheet(isPresented: $showingAddItemList, content: {
            MachineAddItemsView(viewModel: viewModel)
                .presentationDetents([.medium])
        })
    }
    
    private var upgradeCell: some View {
        NewSlotMachineViewGridCell()
            .onTapGesture {
                showingUpgradeSheet.toggle()
            }
            // Shows Upgrade sheet menu
            .sheet(isPresented: $showingUpgradeSheet, content: {
                BuyWorkshopView(viewModel: viewModel)
                    .presentationDetents([.medium])
            })
    }
    
    // MARK: - Queue section view
    
    private var queueSection: some View {
        Section(header: secondSectionHeader) {
            ForEach(viewModel.items) { item in
                if !item.inProgress {
                    // In case progress is not 0
                    if item.percent != 0 {
                        // Paused progress item cell
                        MachineViewGridCell(item: item, paused: true, viewModel: viewModel)
                            .onTapGesture {
                                selected = item
                            }
                            // Shows paused item details
                            .sheet(item: $selected) { item in
                                MachineItemDetailsView(item: item, viewModel: viewModel)
                            }
                    } else {
                        // Resular queue item cell
                        QueueMachineViewGridCell(item: item, viewModel: viewModel)
                            .onTapGesture {
                                selected = item
                            }
                            // Shows queue item details
                            .sheet(item: $selected) { item in
                                MachineItemDetailsView(item: item, viewModel: viewModel)
                            }
                    }
                }
            }
        }
    }
    
    // MARK: - Header views
    
    // Workshop section header
    private var sectionHeader: some View {
        SectionHeader(Texts.MachinePage.workshop)
    }
    
    // Queue section header
    private var secondSectionHeader: some View {
        SectionHeader(Texts.MachinePage.queue)
    }
}

// MARK: - Preview

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let environmentObject = BannerViewModel()
        
        return MachineView(modelContext: modelContext)
            .environmentObject(environmentObject)
    } catch {
        fatalError("Failed to create model container.")
    }
}
