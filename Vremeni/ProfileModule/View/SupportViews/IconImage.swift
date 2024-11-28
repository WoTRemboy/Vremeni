//
//  IconImage.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/28/24.
//

import SwiftUI

struct IconImage: View {
    var icon: Icon

    var body: some View {
        Label {
            Text(icon.rawValue)
        } icon: {
            Image(uiImage: UIImage(named: icon.rawValue + "Preview") ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(minHeight: 57, maxHeight: 1024)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
        }
            .labelStyle(.iconOnly)
    }
}

#Preview {
    IconImage(icon: Icon.primary)
}
