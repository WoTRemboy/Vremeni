//
//  MachineAddItemsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/5/24.
//

import SwiftUI
import SwiftData

struct MachineAddItemsView: View {
    @Environment(\.dismiss) var dismiss
    
    private let viewModel: MachineView.MachineViewModel
    
    init(viewModel: MachineView.MachineViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.items.isEmpty {
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
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var empty: some View {
        VStack {
            Image(systemName: "play.slash")
                .resizable()
                .scaledToFit()
                .fontWeight(.light)
                .foregroundStyle(Color.accentColor, Color.cyan)
                .frame(height: 100)
        }
    }
    
    private var list: some View {
        List {
            ForEach(viewModel.items) { item in
                if !item.inProgress {
                    Button(action: {
                        withAnimation(.snappy) {
                            viewModel.setWorkshop(item: item)
                            dismiss()
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
        
        return MachineAddItemsView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
