//
//  ProfileView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    
    @State private var viewModel: ProfileViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = ProfileViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    internal var body: some View {
        NavigationStack {
            Form {
                profileSection
                statsSection
                otherSection
            }
            .scrollIndicators(.hidden)
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .tabItem {
            Image.TabBar.profile
            Text(Texts.ProfilePage.title)
        }
    }
    
    private var profileSection: some View {
        Section(Texts.ProfilePage.profile) {
            LinkRow(title: Texts.ProfilePage.userName,
                    image: Image(systemName: "person.crop.square.fill"),
                    details: viewModel.profile.name)
            
            LinkRow(title: Texts.ProfilePage.balance,
                    image: Image.ProfilePage.balance,
                    details: String(viewModel.profile.balance))
        }
    }
    
    private var statsSection: some View {
        Section(Texts.ProfilePage.stats) {
            Text(Texts.ProfilePage.charts)
                .frame(maxWidth: .infinity, idealHeight: 300, alignment: .center)
        }
    }
    
    private var otherSection: some View {
        Section(Texts.ProfilePage.other) {
            LinkRow(title: Texts.ProfilePage.archive,
                    image: Image(systemName: "a.square.fill"))
            .overlay(
                NavigationLink(destination: ArchiveView(viewModel: viewModel),
                               label: {
                                   EmptyView()
                               })
            )
            
            LinkRow(title: Texts.ProfilePage.settings,
                    image: Image.ProfilePage.settings)
            .overlay(
                NavigationLink(destination: Text(Texts.ProfilePage.settings),
                               label: {
                                   EmptyView()
                               })
            )
            
            LinkRow(title: Texts.ProfilePage.About.title,
                    image: Image.ProfilePage.about)
            .overlay(
                NavigationLink(destination: ProfileAboutView(viewModel: viewModel),
                               label: {
                                   EmptyView()
                               })
            )
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        return ProfileView(modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
