//
//  ParameterRow.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import SwiftUI

struct ParameterRow: View {
    
    private let title: String
    private let content: String
    private let trailingTitle: String?
    private let trailingContent: String?
    
    init(title: String, content: String, trailingTitle: String? = nil, trailingContent: String? = nil) {
        self.title = title
        self.content = content
        self.trailingTitle = trailingTitle
        self.trailingContent = trailingContent
    }
    
    internal var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundStyle(Color.LabelColors.labelDisable)
            
            titleRow
            contentRow
        }
    }
    
    private var titleRow: some View {
        HStack {
            Text(title)
                .font(.headline())
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top, 14)
            
            if let trailingTitle {
                Text(trailingTitle)
                    .font(.headline())
                    .foregroundStyle(Color.LabelColors.labelPrimary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top, 14)
            }
        }
    }
    
    private var contentRow: some View {
        HStack {
            Text(content)
                .font(.subhead())
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top, 5)
            
            if let trailingContent {
                Text(trailingContent)
                    .font(.subhead())
                    .foregroundStyle(Color.LabelColors.labelSecondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top, 5)
            }
        }
    }
}

#Preview {
    ParameterRow(title: "Description", content: "Description content", trailingTitle: "Trailing", trailingContent: "TrailingContent")
}
