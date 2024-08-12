//
//  MachineViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI
import SwiftData

struct MachineViewGridCell: View {
    
    private let item: MachineItem
    private let paused: Bool
    private let viewModel: MachineView.MachineViewModel
    
    init(item: MachineItem, paused: Bool = false, viewModel: MachineView.MachineViewModel) {
        self.item = item
        self.paused = paused
        self.viewModel = viewModel
    }
    
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                content
                    .padding()
                    .frame(width: reader.size.width, alignment: .leading)
            }
            .background(Color.BackColors.backElevated)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 20)
        }
        .frame(height: 220)
    }
    
    private var content: some View {
        HStack(spacing: 16) {
            VStack(spacing: 10) {
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.light)
                    .foregroundStyle(Color.accentColor, Color.cyan)
                progressBar
                    .padding(.horizontal, 4)
                    .padding(.bottom, -9)
            }
            
            stats
                .frame(maxWidth: .infinity)
        }
    }
    
    private var progressBar: some View {
        ProgressBar(percent: item.percent, color: paused ? .orange : .green)
        .onAppear(perform: {
            if item.inProgress {
                viewModel.startProgress(for: item)
            }
        })
        .onDisappear(perform: {
            if item.percent < 100 && !paused {
                viewModel.stopProgress()
            }
        })
    }
    
    private var stats: some View {
        VStack {
            Text(item.name)
                .lineLimit(1)
                .font(.ruleTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
            
            Text(item.itemDescription)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .font(.subhead())
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .padding(.top, -5)
            
            Spacer()
            progressLabel
                .padding(.top, 5)
            
            buttons
                .padding(.top, 5)
            
        }
        .padding(.top, 10)
    }
    
    private var progressLabel: some View {
        HStack(spacing: 5) {
            Text("\(Texts.ProgressBar.progress):")
                .font(.body())
                .foregroundStyle(Color.labelPrimary)
            
            Text("\(Int(item.percent))%")
                .font(.headline())
                .foregroundStyle(Color.labelPrimary)
        }
    }
    
    private var buttons: some View {
        HStack(spacing: 16) {
            Button(action: {
                withAnimation(.snappy) {
                    if paused {
                        viewModel.setWorkshop(item: item)
                    } else {
                        viewModel.progressDismiss(item: item)
                    }
                }
            }) {
                Image(systemName: paused ? "play" : "pause")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 80, height: 40)
            .foregroundStyle(Color.orange)
            .minimumScaleFactor(0.4)
            .buttonStyle(.bordered)
            .tint(Color.orange)
            .disabled(paused && !viewModel.isSlotAvailable())
            
            Button(action: {
                withAnimation(.snappy) {
                    viewModel.deleteItem(item: item)
                }
            }) {
                Image(systemName: "trash")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 40, height: 40)
            .padding(.trailing, 5)
            .foregroundColor(Color.red)
            .buttonStyle(.bordered)
            .tint(Color.red)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ConsumableItem.self, configurations: config)
        let modelContext = ModelContext(container)
        
        let viewModel = MachineView.MachineViewModel(modelContext: modelContext)
        let example = MachineItem.itemMockConfig(name: "One Hour", description: "One hour is a whole 60 seconds!", price: 1, profile: Profile.configMockProfile())
        return MachineViewGridCell(item: example, viewModel: viewModel)
    } catch {
        fatalError("Failed to create model container.")
    }
}
