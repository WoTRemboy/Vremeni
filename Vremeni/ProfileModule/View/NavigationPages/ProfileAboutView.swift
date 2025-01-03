//
//  ProfileAboutView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/11/24.
//

import SwiftUI
import SwiftData

struct ProfileAboutView: View {
    
    @EnvironmentObject private var iconVM: IconChangerViewModel
    private var viewModel: ProfileView.ProfileViewModel
    
    init(viewModel: ProfileView.ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        NavigationStack {
            Form {
                Section(Texts.ProfilePage.About.version) {
                    version
                }
                
                Section(Texts.ProfilePage.About.team) {
                    director
                    designer
                    developer
                }
                Section(Texts.ProfilePage.About.contact) {
                    email
                }
            }
            .onAppear {
                viewModel.updateVersionOnAppear()
            }
            .navigationTitle(Texts.ProfilePage.About.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var version: some View {
        HStack(spacing: 16) {
            iconVM.previewIcon
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(.buttonBorder)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(Texts.Common.title)
                    .font(.title())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                
                Text(viewModel.version)
                    .font(.subhead())
                    .foregroundStyle(Color.LabelColors.labelSecondary)
            }
            Spacer()
        }
    }
    
    private var director: some View {
        LinkRow(title: Texts.ProfilePage.About.director,
                image: Image.ProfilePage.About.crown,
                details: Texts.ProfilePage.About.father)
    }
    
    private var designer: some View {
        Link(destination: URL(string: Texts.ProfilePage.About.designerLink)!, label: {
            
            LinkRow(title: Texts.ProfilePage.About.designer,
                    image: Image.ProfilePage.About.graphic,
                    details: Texts.ProfilePage.About.pups,
                    chevron: true)
        })
    }
    
    private var developer: some View {
        Link(destination: URL(string: Texts.ProfilePage.About.developLink)!, label: {
            
            LinkRow(title: Texts.ProfilePage.About.developer,
                    image: Image.ProfilePage.About.develop,
                    details: Texts.ProfilePage.About.me,
                    chevron: true)
        })
    }
    
    private var email: some View {
        Link(destination: URL(string: "mailto:\(Texts.ProfilePage.About.realEmail)")!, label: {
            
            LinkRow(title: Texts.ProfilePage.About.email,
                    image: Image.ProfilePage.About.email,
                    details: Texts.ProfilePage.About.emailContent,
                    chevron: true)
        })
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Profile.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        return ProfileAboutView(viewModel: viewModel)
            .environmentObject(IconChangerViewModel())
    } catch {
        fatalError("Failed to create model container.")
    }
}
