//
//  NewUsernameView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/13/24.
//

import SwiftUI
import SwiftData

struct NewUsernameView: View {
    
    @Environment(\.dismiss) var dismiss
    private var viewModel: ProfileView.ProfileViewModel
    
    @State private var username: String
    private var currentName: String
    
    init(username: String, viewModel: ProfileView.ProfileViewModel) {
        self.username = username
        self.currentName = username
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                VStack {
                    textField
                    buttons
                }
                .padding()
                .frame(width: reader.size.width, alignment: .leading)
            }
        }
        .frame(height: 155)
    }
    
    private var textField: some View {
        TextField(Texts.ProfilePage.username, text: $username)
            .onChange(of: username) {
                username = username.replacing(" ", with: "")
            }
            .font(.title())
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .padding()
            .background(Color.SupportColors.supportTextField)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Tints.orange, lineWidth: 4)
            )
    }
    
    private var buttons: some View {
        HStack(spacing: 16) {
            cancelButton
            acceptButton
        }
        .padding(.top, 10)
    }
    
    private var cancelButton: some View {
        Button(action: {
            withAnimation(.snappy) {
                dismiss()
            }
        }) {
            Text(Texts.ProfilePage.cancel)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 40)
        .minimumScaleFactor(0.4)
        .padding(.top, 5)
        
        .foregroundStyle(Color.red)
        .buttonStyle(.bordered)
        .tint(Color.red)
    }
    
    private var acceptButton: some View {
        Button(action: {
            withAnimation(.snappy) {
                viewModel.changeNickname(to: username)
                dismiss()
            }
        }) {
            Text(Texts.ProfilePage.accept)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 40)
        .minimumScaleFactor(0.4)
        .padding(.top, 5)
        .disabled(username.isEmpty || username == currentName)
        
        .foregroundStyle(Color.green)
        .buttonStyle(.bordered)
        .tint(Color.green)
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        return NewUsernameView(username: "User228", viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}

