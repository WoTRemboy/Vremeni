//
//  IconChooserView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/28/24.
//

import SwiftUI

struct IconChooserView: View {
    @EnvironmentObject private var viewModel: IconChangerViewModel

    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)

        VStack {
            HStack {
                Text("Select an icon:")
                    .font(.largeTitle)
                IconImage(icon: viewModel.appIcon)
                    .frame(maxHeight: 114)
            }
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Icon.allCases) { icon in
                        Button {
                            viewModel.setAlternateAppIcon(icon: icon)
                        } label: {
                            IconImage(icon: icon)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    IconChooserView()
        .environmentObject(IconChangerViewModel())
}
