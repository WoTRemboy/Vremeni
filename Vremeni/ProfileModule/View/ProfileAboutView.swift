//
//  ProfileAboutView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/11/24.
//

import SwiftUI
import SwiftData

struct ProfileAboutView: View {
    
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
            .navigationTitle(Texts.ProfilePage.About.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var version: some View {
        HStack(spacing: 10) {
            Image.ProfilePage.About.appIcon
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(.buttonBorder)
                .padding(.leading, -2.5)
            
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
        LinkRow(title: Texts.ProfilePage.About.father,
                image: Image.ProfilePage.About.crown,
                details: Texts.ProfilePage.About.director)
    }
    
    private var developer: some View {
        Link(destination: URL(string: Texts.ProfilePage.About.developLink)!, label: {
            
            LinkRow(title: Texts.ProfilePage.About.me,
                    image: Image.ProfilePage.About.develop,
                    details: Texts.ProfilePage.About.developer,
                    chevron: true)
        })
    }
    
    private var designer: some View {
        Link(destination: URL(string: Texts.ProfilePage.About.designerLink)!, label: {
            
            LinkRow(title: Texts.ProfilePage.About.pups,
                    image: Image.ProfilePage.About.graphic,
                    details: Texts.ProfilePage.About.designer,
                    chevron: true)
        })
    }
    
    private var email: some View {
        Link(destination: URL(string: "mailto:\(Texts.ProfilePage.About.emailContent)")!, label: {
            
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
    } catch {
        fatalError("Failed to create model container.")
    }
}
