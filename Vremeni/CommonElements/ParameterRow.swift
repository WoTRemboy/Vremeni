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
    private let trailingContent: String?
    
    init(title: String, content: String, trailingContent: String? = nil) {
        self.title = title
        self.content = content
        self.trailingContent = trailingContent
    }
    
    internal var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundStyle(Color.LabelColors.labelDisable)
            
            HStack {
                VStack(spacing: 0) {
                    titleView
                    contentView
                }

                if let trailingContent {
                    trailingView
                }
            }
        }
    }
    
    private var titleView: some View {
        Text(title)
            .font(.headline())
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.top, 14)
    }
    
    private var contentView: some View {
        Text(content)
            .font(.subhead())
            .foregroundStyle(Color.LabelColors.labelSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.top, 5)
    }
    
    private var trailingView: some View {
        Text(trailingContent ?? String())
            .font(.ruleTitle())
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            .padding(.top, 14)
    }
}

#Preview {
    ParameterRow(title: "Description", content: "Description content", trailingContent: "57%")
}
