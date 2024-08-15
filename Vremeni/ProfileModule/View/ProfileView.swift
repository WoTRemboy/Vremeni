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
                profileSection
                statsSection
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
                        image: Image.ProfilePage.person,
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
        Section(Texts.ProfilePage.content) {
            NavigationLink(destination: ArchiveView(viewModel: viewModel),
                           label: {
                LinkRow(title: Texts.ProfilePage.archive,
                        image: Image.ProfilePage.archive)
            })
            resetButton
        }
    }
    
    private var resetButton: some View {
        Button {
            showingAlert = true
        } label: {
            LinkRow(title: Texts.ProfilePage.reset,
                    image: Image.ProfilePage.reset,
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
            
            NavigationLink(destination: ProfileAboutView(viewModel: viewModel),
                           label: {
                LinkRow(title: Texts.ProfilePage.About.title,
                        image: Image.ProfilePage.about)
            })
            
            NavigationLink(destination: Text(Texts.ProfilePage.settings),
                           label: {
                LinkRow(title: Texts.ProfilePage.settings,
                        image: Image.ProfilePage.settings)
            })
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
