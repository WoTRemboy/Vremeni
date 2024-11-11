//
//  LinkRow.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/11/24.
//

import SwiftUI

struct LinkRow: View {
    
    private let title: String
    private let description: String?
    private let image: Image
    private let details: String?
    private let chevron: Bool
    
    init(title: String, description: String? = nil, image: Image,
         details: String? = nil, chevron: Bool = false) {
        self.title = title
        self.description = description
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
                    .lineLimit(1)
                    .foregroundStyle(Color.LabelColors.labelSecondary)
            }
            
            if chevron {
                Image(systemName: "chevron.right")
                    .font(.footnote())
                    .fontWeight(.bold)
                    .foregroundStyle(Color.LabelColors.labelDetails)
            }
        }
    }
    
    private var leftLabel: some View {
        HStack(alignment: (description != nil) ? .top : .center, spacing: 16) {
            image
                .resizable()
                .scaledToFit()
                .clipShape(.buttonBorder)
                .padding(.top, (description != nil) ? 3 : 0)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.regularBody())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                
                if let description {
                    Text(description)
                        .font(.lightFootnote())
                        .foregroundStyle(Color.LabelColors.labelSecondary)
                }
            }
        }
    }
}


#Preview {
    LinkRow(title: "Title", description: "Unlimited posting, priority order, stealth mode, permanent view history and more.", image: Image.ProfilePage.About.email, details: "hi", chevron: true)
}
