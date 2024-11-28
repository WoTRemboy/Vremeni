//
//  IconChooserView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/28/24.
//

import SwiftUI

struct IconChooserView: View {
    @EnvironmentObject private var viewModel: IconChangerViewModel

    internal var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
        
        LazyVGrid(columns: columns) {
            ForEach(Icon.allCases) { icon in
                Button {
                    viewModel.setAlternateAppIcon(icon: icon)
                } label: {
                    IconImage(icon: icon, selected: viewModel.appIcon == icon)
                }
                .buttonStyle(.plain)
                .animation(.easeInOut(duration: 0.2), value: viewModel.appIcon)
            }
        }
    }
}

#Preview {
    IconChooserView()
        .environmentObject(IconChangerViewModel())
}
