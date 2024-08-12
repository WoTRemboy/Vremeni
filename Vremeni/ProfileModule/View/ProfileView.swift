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
                Section(Texts.ProfilePage.userName) {
                    Text(viewModel.profile.name)
                }
                
                Section(Texts.ProfilePage.other) {
                    NavigationLink {
                        ProfileAboutView(viewModel: viewModel)
                    } label: {
                        Text(Texts.ProfilePage.About.title)
                    }

                }
            }
            .navigationTitle(Texts.Common.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .tabItem {
            Image.TabBar.profile
            Text(Texts.ProfilePage.title)
        }
    }
    
    private var version: some View {
        HStack(spacing: 10) {
            Image.ProfilePage.about
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
