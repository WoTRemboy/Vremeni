//
//  IconImage.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/28/24.
//

import SwiftUI

struct IconImage: View {
    
    private var icon: Icon
    private var selected: Bool
    
    init(icon: Icon, selected: Bool) {
        self.icon = icon
        self.selected = selected
    }

    internal var body: some View {
        VStack {
            Image(uiImage: UIImage(named: icon.rawValue + Texts.ProfilePage.preview) ?? UIImage())
                .resizable()
                .scaledToFit()
            
                .cornerRadius(16)
                .frame(height: 70)
            
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(selected ? Color.blue : Color.LabelColors.labelDisable,
                                    lineWidth: selected ? 2 : 1)
                    )
            
            Text(icon.name)
                .lineLimit(1)
                .font(Font.system(size: 15, weight: .regular))
                .foregroundStyle(selected ? Color.blue : Color.LabelColors.labelPrimary)
        }
    }
}

#Preview {
    IconImage(icon: Icon.primary, selected: true)
}
