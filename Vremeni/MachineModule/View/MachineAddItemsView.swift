//
//  MachineAddItemsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/5/24.
//

import SwiftUI
import SwiftData

struct MachineAddItemsView: View {
    
    private let viewModel: MachineView.MachineViewModel
    private var onDismiss: () -> Void
    
    init(viewModel: MachineView.MachineViewModel,
         onDismiss: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onDismiss = onDismiss
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.queuedItems.isEmpty {
                    background
                    empty
                } else {
                    list
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle(Texts.MachinePage.queue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        onDismiss()
                    }
                }
            }
        }
    }
    
    private var empty: some View {
        PlaceholderView(title: Texts.MachinePage.placeholderTitle,
                        description: Texts.MachinePage.placeholderSubtitle,
                        status: .machine)
    }
    
    private var background: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .foregroundStyle(Color.clear)
            .background(Color.BackColors.backiOSPrimary)
    }
    
    private var list: some View {
        List {
            ForEach(viewModel.items) { item in
                if item.status != .processing {
                    Button(action: {
                        withAnimation(.snappy) {
                            viewModel.setWorkshop(item: item)
                            onDismiss()
                        }
                        if viewModel.notificationStatus == .allowed {
                            viewModel.notificationSetup(for: item)
                        }
                    }) {
                        ItemListRow(item: item)
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        viewModel.addSamples()
        
        return MachineAddItemsView(viewModel: viewModel, onDismiss: {})
    } catch {
        fatalError("Failed to create model container.")
    }
}
