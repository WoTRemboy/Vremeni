//
//  ProfileView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    
    @EnvironmentObject private var bannerService: BannerViewModel
    @State private var viewModel: ProfileViewModel
    @State private var showingUsernameSheet = false
    @State private var showingResetAlert = false
    @State private var showingLanguageAlert = false
    
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
            .toolbarBackground(.visible, for: .tabBar)
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
                    .presentationDetents([.height(150)])
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
                .overlay {
                    NavigationLink(destination: ChartsDetailsView(viewModel: viewModel)) {
                        EmptyView()
                    }
                    .opacity(0)
                }
        }
    }
    
    private var contentSection: some View {
        Section(Texts.ProfilePage.content) {
            NavigationLink(destination: ArchiveView(viewModel: viewModel)) {
                LinkRow(title: Texts.ProfilePage.archive,
                        image: Image.ProfilePage.archive)
            }
            languageButton
            resetButton
        }
    }
    
    private var languageButton: some View {
        Button {
            showingLanguageAlert = true
        } label: {
            LinkRow(title: Texts.ProfilePage.language,
                    image: Image.ProfilePage.language,
                    chevron: true)
        }
        .alert(isPresented:$showingLanguageAlert) {
            Alert(
                title: Text(Texts.ProfilePage.languageTitle),
                message: Text(Texts.ProfilePage.languageContent),
                primaryButton: .default(Text(Texts.ProfilePage.settings)) {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    UIApplication.shared.open(url)
                },
                secondaryButton: .cancel(Text(Texts.ProfilePage.cancel))
            )
        }
    }
    
    private var resetButton: some View {
        Button {
            showingResetAlert = true
        } label: {
            LinkRow(title: Texts.ProfilePage.reset,
                    image: Image.ProfilePage.reset,
                    chevron: true)
        }
        .confirmationDialog(Texts.ProfilePage.resetContent,
                            isPresented: $showingResetAlert,
                            titleVisibility: .visible) {
            Button(role: .destructive) {
                withAnimation {
                    viewModel.resetProgress()
                    bannerService.setBanner(banner: .reset(message: Texts.Banner.reset))
                }
            } label: {
                Text(Texts.ProfilePage.resetButton)
            }
        }
    }
    
    private var appSection: some View {
        Section(Texts.ProfilePage.app) {
            Toggle(isOn: $viewModel.notificationsEnabled) {
                LinkRow(title: Texts.ProfilePage.notifications,
                        image: Image.ProfilePage.notifications)
            }
            .onChange(of: viewModel.notificationsEnabled) { _, newValue in
                viewModel.setNotificationsStatus(allowed: newValue)
            }
            
            NavigationLink(destination: Text(Texts.ProfilePage.appearance),
                           label: {
                LinkRow(title: Texts.ProfilePage.appearance,
                        image: Image.ProfilePage.appearance)
            })
            
            
            NavigationLink(destination: ProfileAboutView(viewModel: viewModel),
                           label: {
                LinkRow(title: Texts.ProfilePage.About.title,
                        image: Image.ProfilePage.about)
            })
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let environmentObject = BannerViewModel()
        
        return ProfileView(modelContext: modelContext)
            .environmentObject(environmentObject)
    } catch {
        fatalError("Failed to create model container.")
    }
}
