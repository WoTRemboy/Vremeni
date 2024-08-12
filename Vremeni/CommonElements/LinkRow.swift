//
//  LinkRow.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/11/24.
//

import SwiftUI

struct LinkRow: View {
    
    private let title: String
    private let image: Image
    private let details: String?
    private let chevron: Bool
    
    init(title: String, image: Image,
         details: String? = nil, chevron: Bool = false) {
        self.title = title
        self.image = image
        self.details = details
        self.chevron = chevron
    }
    
    internal var body: some View {
        HStack {
            leftLabel
            
            Spacer()
            if let details {
                Text(details)
                    .font(.regularBody())
                    .foregroundStyle(Color.LabelColors.labelSecondary)
            }
            
            if chevron {
                Image(systemName: "chevron.right")
                    .font(.footnote())
                    .foregroundStyle(Color.LabelColors.labelTertiary)
            }
        }
    }
    
    private var leftLabel: some View {
        Label(
            title: {
                Text(title)
                    .font(.regularBody())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
            },
            icon: {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.buttonBorder)
            }
        )
    }
}


#Preview {
    LinkRow(title: "Title", image: Image.ProfilePage.About.email, details: "hi", chevron: true)
}
