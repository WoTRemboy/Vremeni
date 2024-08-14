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
    @State private var showingUsernameSheet = false
    @State private var showingAlert = false
    
    init(modelContext: ModelContext) {
        let viewModel = ProfileViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    internal var body: some View {
        NavigationStack {
            Form {
                statsSection
                profileSection
                contentSection
                appSection
            }
            .onAppear {
                viewModel.updateOnAppear()
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
            Button {
                showingUsernameSheet = true
            } label: {
                LinkRow(title: Texts.ProfilePage.username,
                        image: Image(systemName: "person.crop.square.fill"),
                        details: viewModel.profile.name,
                        chevron: true)
            }
            .sheet(isPresented: $showingUsernameSheet, content: {
                NewUsernameView(username: viewModel.profile.name, viewModel: viewModel)
                    .presentationDetents([.height(150 + 16)])
            })
            
            LinkRow(title: Texts.ProfilePage.balance,
                    image: Image.ProfilePage.balance,
                    details: String(viewModel.profile.balance))
        }
    }
    
    private var statsSection: some View {
        Section(Texts.ProfilePage.stats) {
            StatisticsChartView(viewModel: viewModel)
                .frame(maxWidth: .infinity, idealHeight: 300, alignment: .center)
        }
    }
    
    private var contentSection: some View {
        Section("Content") {
            LinkRow(title: Texts.ProfilePage.archive,
                    image: Image(systemName: "a.square.fill"))
            .overlay(
                NavigationLink(destination: ArchiveView(viewModel: viewModel),
                               label: {
                                   EmptyView()
                               })
            )
            resetButton
        }
    }
    
    private var resetButton: some View {
        Button {
            showingAlert = true
        } label: {
            LinkRow(title: Texts.ProfilePage.reset,
                    image: Image(systemName: "minus.square.fill"),
                    chevron: true)
        }
        .confirmationDialog(Texts.ProfilePage.resetContent,
                            isPresented: $showingAlert,
                            titleVisibility: .visible) {
            Button(role: .destructive) {
                viewModel.resetProgress()
            } label: {
                Text(Texts.ProfilePage.resetButton)
            }
        }
    }
    
    private var appSection: some View {
        Section(Texts.ProfilePage.app) {
            
            LinkRow(title: Texts.ProfilePage.About.title,
                    image: Image.ProfilePage.about)
            .overlay(
                NavigationLink(destination: ProfileAboutView(viewModel: viewModel),
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
