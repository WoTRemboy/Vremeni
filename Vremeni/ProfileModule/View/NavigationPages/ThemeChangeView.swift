//
//  ThemeChangeView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/26/24.
//

import SwiftUI

struct ThemeChangeView: View {
    
    @Environment(\.colorScheme) private var scheme
    @AppStorage(Texts.UserDefaults.theme) private var userTheme: Theme = .systemDefault
    
    internal var body: some View {
        content
    }
    
    private var content: some View {
        VStack(spacing: 10) {
            Circle()
                .fill(userTheme.color(scheme))
                .frame(width: 150)
            
            Text(Texts.ProfilePage.theme)
                .font(.ruleTitle())
                .padding(.top, 25)
            
            Picker(Texts.ProfilePage.theme, selection: $userTheme.animation()) {
                Text(Texts.ProfilePage.system).tag(Theme.systemDefault)
                Text(Texts.ProfilePage.light).tag(Theme.light)
                Text(Texts.ProfilePage.dark).tag(Theme.dark)
            }
            .pickerStyle(.segmented)
            .padding()
        }
        .frame(maxWidth: .infinity, idealHeight: 350, maxHeight: .infinity)
        .background(Color.BackColors.backDefault)
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal)
    }
}

#Preview {
    ThemeChangeView()
}
