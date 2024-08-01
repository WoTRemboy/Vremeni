//
//  ProfileView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(Texts.ProfilePage.version) {
                    version
                }
                // Joke
                Section("CEO") {
                    Text("Mikhail Tverdokhleb 👑")
                }
                Section("Bondman") {
                    Text("Roman Tverdokhleb ⛏️")
                }
                Section("Company of the year") {
                    Text("Vremeni Inc. 💸")
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
    ProfileView()
}
