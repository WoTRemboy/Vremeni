//
//  ProfileView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Text(Texts.ProfilePage.title)
            .tabItem {
                Image(systemName: "person")
                Text(Texts.ProfilePage.title)
            }
    }
}

#Preview {
    ProfileView()
}
