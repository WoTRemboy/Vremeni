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
                        .padding([.horizontal, .bottom])
                }
                .onAppear {
                    viewModel.updateItemsOnAppear()
                }
                
                if viewModel.archivedItems.isEmpty {
                    placeholder
                }
            }
            .scrollDisabled(viewModel.archivedItems.isEmpty)
            .scrollDismissesKeyboard(.immediately)
            .background(Color.BackColors.backDefault)
            
            .navigationTitle(Texts.ProfilePage.Archive.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    private var collection: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing),
            count: itemsInRows)
        
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(viewModel.archivedItems) { item in
                    ArchiveGridCell(item: item, viewModel: viewModel)
                        .onTapGesture {
                            selected = item
                        }
            }
            .sheet(item: $selected) { item in
                ArchiveDetailsView(item: item, viewModel: viewModel)
            }
        }
    }
    
    private var placeholder: some View {
        PlaceholderView(title: Texts.ProfilePage.Archive.placeholderTitle,
                        description: Texts.ProfilePage.Archive.placeholderSubtitle,
                        status: .archive)
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
