//
//  ConsumableItemCreate.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/30/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ConsumableItemCreate: View {
    
    // MARK: - Properties
    
    @State private var item: ConsumableItem
    @State private var showingResearchItemList = false
    @State private var isKeyboardVisible = false
    
    @State private var selectedPhoto: PhotosPickerItem?
    
    private var viewModel: ShopView.ShopViewModel
    private var onDismiss: () -> Void
    
    // MARK: - Initialization
    
    init(viewModel: ShopView.ShopViewModel, onDismiss: @escaping () -> Void) {
        self.viewModel = viewModel
        self.item = ConsumableItem.itemConfig(
            nameKey: String(), price: 1,
            profile: viewModel.profile, enabled: false)
        self.onDismiss = onDismiss
    }
    
    // MARK: - Body View
    
    internal var body: some View {
        NavigationStack {
            // main content form view
            form
                .scrollIndicators(.hidden)
            
            // Set up keyboard observer
                .onAppear(perform: setupKeyboardObserver)
                .onDisappear(perform: removeKeyboardObserver)
            
            // Navigation bar params
                .navigationTitle(Texts.ItemCreatePage.title)
                .navigationBarTitleDisplayMode(.inline)
            
            // ToolBar buttons
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        cancelButton
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        saveDoneButton
                    }
                }
                .task(id: selectedPhoto) {
                    if let data = try? await selectedPhoto?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        
                        if let croppedImage = viewModel.cropToSquare(image: uiImage),
                           let resizedImage = viewModel.resizeImage(image: croppedImage, targetSize: CGSize(width: 300, height: 300)) {
                            if let resizedData = resizedImage.jpegData(compressionQuality: 0.8) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    item.image = resizedData
                                }
                            }
                        }
                    }
                }
        }
    }
    
    // MARK: - ToolBar buttons
    
    // Dismiss button
    private var cancelButton: some View {
        Button(Texts.ItemCreatePage.cancel) {
            onDismiss()
        }
    }
    
    // Button with save item action
    private var saveDoneButton: some View {
        Button {
            if isKeyboardVisible {
                // Hide keyboard on "Done"
                hideKeyboard()
            } else {
                withAnimation(.snappy) {
                    viewModel.saveItem(item)
                    onDismiss()
                }
            }
        } label: {
            Text(isKeyboardVisible ? Texts.ItemCreatePage.done : Texts.ItemCreatePage.save)
                .animation(.easeInOut(duration: 0.3))
        }
        // Disable Save when name is empty
        .disabled(!isKeyboardVisible && item.name.isEmpty)
    }
    
    // MARK: - Content form view
    
    // Form with general, valuation & turnover sections
    private var form: some View {
        Form {
            previewSection
            generalSection
            valuationSection
            
            if !item.enabled {
                researchSection
                    .transition(.move(edge: .trailing))
            }
        }
        
        .animation(.easeInOut(duration: 0.2), value: item.enabled)
        
    }
    
    private var previewSection: some View {
        Section(Texts.ItemCreatePage.preview) {
            PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                if let image = item.image, let _ = UIImage(data: image) {
                    TurnoverItemListRow(item: item)
                } else {
                    TurnoverItemListRow(item: item, preview: true)
                }
            }
        }
    }
    
    private var generalSection: some View {
        Section(Texts.ItemCreatePage.general) {
            // Sets ConsumableItem name
            TextField(Texts.ItemCreatePage.name, text: $item.nameKey)
            // Sets ConsumableItem description
            TextField(Texts.ItemCreatePage.description, text: $item.descriptionKey, axis: .vertical)
            // Sets ConsumableItem enable status
            Toggle(Texts.ShopPage.available, isOn: $item.enabled)
        }
    }
    
    private var valuationSection: some View {
        Section(Texts.ItemCreatePage.valuation) {
            // Sets ConsumableItem rarity value
            picker
            // Displays ConsumableItem price value
            totalPriceView
            // Sets ConsumableItem price value
            Slider(value: $item.price, in: 1...1000, step: 1)
        }
    }
    
    private var researchSection: some View {
        Section(Texts.ItemCreatePage.research) {
            ForEach(item.requirements, id: \.self) { requirement in
                ResearchItemListRow(item: item, requirement: requirement)
            }
            .onDelete(perform: item.removeRequirement)
            
            Button {
                hideKeyboard()
                showingResearchItemList.toggle()
            } label: {
                Text(Texts.ItemCreatePage.addItem)
                    .foregroundStyle(Color.LabelColors.labelSecondary)
                    .font(.regularBody())
            }
            .sheet(isPresented: $showingResearchItemList) {
                ConsumableItemAddView(item: $item, viewModel: viewModel) {
                    showingResearchItemList.toggle()
                }
            }
        }
    }
    
    // MARK: - Valuation section support views
    
    // ConsumableItem rarity picker
    private var picker: some View {
        Picker(Texts.ItemCreatePage.rarity, selection: $item.rarity) {
            Text(Texts.Rarity.common).tag(Rarity.common)
            Text(Texts.Rarity.uncommon).tag(Rarity.uncommon)
            Text(Texts.Rarity.rare).tag(Rarity.rare)
            Text(Texts.Rarity.epic).tag(Rarity.epic)
            Text(Texts.Rarity.legendary).tag(Rarity.legendary)
            Text(Texts.Rarity.mythic).tag(Rarity.mythic)
            Text(Texts.Rarity.exotic).tag(Rarity.exotic)
            Text(Texts.Rarity.final).tag(Rarity.final)
        }
    }
    
    // ConsumableItem price value & vCoin icon
    private var totalPriceView: some View {
        HStack(spacing: 5) {
            Text(Texts.ItemCreatePage.total)
            
            Spacer()
            Text(String(Int(item.price)))
            Image.ShopPage.vCoin
                .resizable()
                .scaledToFit()
                .frame(width: 17)
        }
    }
    
    // MARK: - Keyboard Handling
    
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = true
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = false
        }
    }
    
    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Preview

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = ShopView.ShopViewModel(modelContext: modelContext)
        
        return ConsumableItemCreate(viewModel: viewModel, onDismiss: {})
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
