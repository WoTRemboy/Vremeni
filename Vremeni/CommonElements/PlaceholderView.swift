//
//  PlaceholderView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/9/24.
//

import SwiftUI

struct PlaceholderView: View {
    
    private let title: String
    private let description: String
    private let status: PlaceholderStatus
    
    init(title: String, description: String, status: PlaceholderStatus) {
        self.title = title
        self.description = description
        self.status = status
    }
    
    internal var body: some View {
        VStack(spacing: 3) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 45)
                .foregroundStyle(Color.LabelColors.labelSecondary)
            
            Text(title)
                .font(.placeholderTitle())
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .padding(.top)
            
            Text(description)
                .font(.subhead())
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .multilineTextAlignment(.center)
        }
    }
    
    private var image: Image {
        switch status {
        case .search:
            Image.Placeholder.search
        case .unlocked:
            Image.Placeholder.unlocked
        case .locked:
            Image.Placeholder.locked
        case .machine:
            Image.Placeholder.machine
        case .inventory:
            Image.Placeholder.inventory
        case .archive:
            Image.Placeholder.archive
        }
    }
}

enum PlaceholderStatus {
    case search
    case unlocked
    case locked
    case machine
    case inventory
    case archive
}

#Preview {
    PlaceholderView(title: "Title", description: "Description", status: .search)
}
