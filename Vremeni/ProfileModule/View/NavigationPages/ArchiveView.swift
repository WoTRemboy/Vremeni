//
//  ArchiveView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/12/24.
//

import SwiftUI
import SwiftData

struct ArchiveView: View {
    
    @State private var selected: ConsumableItem? = nil
    @State private var searchText = String()
    
    private var viewModel: ProfileView.ProfileViewModel
    private let spacing: CGFloat = 16
    private let itemsInRows = 1
    
    init(viewModel: ProfileView.ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    collection
                        .padding(.horizontal)
                }
                .onAppear {
                    viewModel.updateItemsOnAppear()
                }
            }
            .scrollDisabled(viewModel.items.isEmpty)
            .scrollDismissesKeyboard(.immediately)
            .background(Color.BackColors.backDefault)
            
            .navigationTitle(Texts.ProfilePage.Archive.title)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: Texts.ShopPage.searchItems)
        }
    }
    
    
    private var collection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(searchResults) { item in
                    ArchiveGridCell(item: item, viewModel: viewModel)
                        .onTapGesture {
                            selected = item
                        }
            }
            .sheet(item: $selected) { item in

            }
        }
    }
    
    private var searchResults: [ConsumableItem] {
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter { $0.name.contains(searchText) }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Profile.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        viewModel.addSamples()
        
        return ArchiveView(viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
