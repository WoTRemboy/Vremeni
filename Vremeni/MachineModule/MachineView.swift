//
//  MachineView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct MachineView: View {
    var body: some View {
        Text(Texts.MachinePage.title)
            .tabItem {
                Image(systemName: "clock.arrow.2.circlepath")
                Text(Texts.MachinePage.title)
            }
    }
}

#Preview {
    MachineView()
}
