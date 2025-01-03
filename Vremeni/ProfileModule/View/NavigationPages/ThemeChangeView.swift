//
//  ThemeChangeView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/26/24.
//

import SwiftUI
import SwiftData

struct ThemeChangeView: View {
        
    @Environment(\.colorScheme) private var scheme
    
    @AppStorage(Texts.UserDefaults.theme) private var userTheme: Theme = .systemDefault
    @State private var circleOffset: CGSize = .zero
    @State private var circleSize: CGFloat = 0
    
    private var viewModel: ProfileView.ProfileViewModel
    private var iconVM: IconChangerViewModel
    private var onDismiss: () -> Void
    
    init(viewModel: ProfileView.ProfileViewModel,
         iconVM: IconChangerViewModel,
         onDismiss: @escaping () -> Void) {
        self.viewModel = viewModel
        self.iconVM = iconVM
        self.onDismiss = onDismiss
    }
    
    internal var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                planet
                picker
                separator
                iconChooser
                Spacer()
            }
            .onAppear {
                (circleOffset, circleSize) = viewModel.selectShape(userTheme)
            }
            
            .onChange(of: userTheme) { oldTheme, newTheme in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    viewModel.changeTheme(theme: newTheme)
                }
                withAnimation(.snappy(duration: 0.2)) {
                    (circleOffset, circleSize) = viewModel.selectShape(newTheme)
                }
            }
            
            .frame(maxWidth: .infinity, idealHeight: 350, maxHeight: .infinity)
            .background(Color.BackColors.backSecondary)
            
            .navigationTitle(Texts.ProfilePage.theme)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Texts.ProfilePage.done) {
                        onDismiss()
                    }
                }
            }
        }
    }
    
    private var planet: some View {
        Circle()
            .fill(userTheme.color(scheme))
            .frame(width: 180)
            .mask {
                Rectangle()
                    .overlay {
                        Circle()
                            .offset(circleOffset)
                            .blendMode(.destinationOut)
                            .frame(width: circleSize)
                    }
                
            }
            .padding(.top)
    }
    
    private var picker: some View {
        Picker(Texts.ProfilePage.theme, selection: $userTheme) {
            ForEach(Theme.allCases, id: \.self) { theme in
                Text(theme.name).tag(theme)
            }
        }
        .pickerStyle(.segmented)
        .padding(.top, 25)
        .padding([.horizontal, .bottom])
    }
    
    private var separator: some View {
        Rectangle()
            .padding(.horizontal)
            .frame(height: 1)
            .foregroundStyle(Color.LabelColors.labelDisable)
    }
    
    private var iconChooser: some View {
        IconChooserView()
            .environmentObject(iconVM)
            .padding(.top)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ProfileView.ProfileViewModel(modelContext: modelContext)
        return ThemeChangeView(viewModel: viewModel, iconVM: IconChangerViewModel(), onDismiss: {})
    } catch {
        fatalError("Failed to create model container.")
    }
}
