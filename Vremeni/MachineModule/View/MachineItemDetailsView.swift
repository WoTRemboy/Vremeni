//
//  MachineItemDetailsView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/5/24.
//

import SwiftUI
import SwiftData

struct MachineItemDetailsView: View {
    
    private let item: MachineItem
    private var viewModel: MachineView.MachineViewModel
    private var onDismiss: () -> Void
    
    init(item: MachineItem,
         viewModel: MachineView.MachineViewModel,
         onDismiss: @escaping () -> Void) {
        self.item = item
        self.viewModel = viewModel
        self.onDismiss = onDismiss
    }
    
    internal var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 5) {
                    itemHead
                    params
                        .padding(.top, 20)
                    
                    TotalPrice(price: item.price)
                        .padding(.top, 30)
                    
                    buyButton
                        .padding([.top, .horizontal])
                    
                    Spacer()
                }
            }
            .navigationTitle(Texts.ItemCreatePage.details)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Texts.ItemCreatePage.cancel) {
                        onDismiss()
                    }
                }
            }
        }
    }
    
    private var itemHead: some View {
        VStack(spacing: 5) {
            if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .clipShape(.buttonBorder)
                    .frame(width: 200, height: 200)
            } else {
                Image.Placeholder.placeholder1to1
                    .resizable()
                    .clipShape(.buttonBorder)
                    .frame(width: 200, height: 200)
            }
            
            Text(item.name)
                .font(.segmentTitle())
                .padding(.top, 10)
            
            HStack(spacing: 5) {
                item.rarity.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text(item.rarity.name)
                    .font(.body())
            }
        }
    }
    
    private var params: some View {
        VStack(spacing: 14) {
            ParameterRow(title: Texts.ItemCreatePage.description,
                         content: item.itemDescription.isEmpty ? Texts.ItemCreatePage.null : item.itemDescription)
            
            if item.status == .processing {
                ParameterRow(title: Texts.MachinePage.targetTime,
                             content: Date.itemFormatter.string(from: item.target))
            } else {
                ParameterRow(title: item.status == .queued ? Texts.MachinePage.potentialTime : Texts.MachinePage.targetTime,
                             content: viewModel.remainingTime(for: item))
            }
            
            ParameterRow(title: Texts.ItemCreatePage.application,
                         contentArray: viewModel.applicationDesctiption(item: item))
            
        }
    }
    
    private var buyButton: some View {
        Button(action: {
            withAnimation(.snappy) {
                if item.status == .processing {
                    viewModel.progressDismiss(item: item)
                    viewModel.notificationRemove(for: item.id)
                } else {
                    viewModel.setWorkshop(item: item)
                    if viewModel.notificationStatus == .allowed {
                        viewModel.notificationSetup(for: item)
                    }
                }
                onDismiss()
            }
        }) {
            if item.status == .processing {
                Text(Texts.MachinePage.pause)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                Text(item.percent != 0 ? Texts.MachinePage.continueProgress : Texts.MachinePage.start)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(height: 50)
        .foregroundStyle(item.percent != 0 ? Color.orange : Color.green)
        .minimumScaleFactor(0.4)
        .buttonStyle(.bordered)
        .tint(item.percent != 0 ? Color.orange : Color.green)
        .disabled((item.status != .processing) && !viewModel.isSlotAvailable())
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        
        let example = MachineItem.itemMockConfig(name: "One Minute", description: "One minute is a whole 60 seconds!", price: 50, rarity: .uncommon, profile: Profile.configMockProfile())
        return MachineItemDetailsView(item: example, viewModel: viewModel, onDismiss: {})
    } catch {
        fatalError("Failed to create model container.")
    }
}
