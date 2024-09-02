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
    private let contentArray: [String]
    private let trailingContent: String?
    private let researchType: ResearchType?
    
    init(title: String, content: String = String(), contentArray: [String] = [], trailingContent: String? = nil, researchType: ResearchType? = nil) {
        self.title = title
        self.content = content
        self.contentArray = contentArray
        self.trailingContent = trailingContent
        self.researchType = researchType
    }
    
    internal var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundStyle(Color.LabelColors.labelDisable)
            
            HStack {
                if researchType != nil {
                    trailingIcon
                }
                VStack(spacing: 0) {
                    titleView
                    
                    if !content.isEmpty {
                        contentView
                    }
                    
                    if !contentArray.isEmpty {
                        contentArrayView
                    }
                }

                if trailingContent != nil {
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
    
    private var contentArrayView: some View {
        VStack(spacing: 5) {
            ForEach(contentArray, id: \.self) { row in
                Text(row)
                    .font(.subhead())
                    .foregroundStyle(Color.LabelColors.labelSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
        }
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
    
    private var trailingIcon: some View {
        researchType?.icon
            .resizable()
            .scaledToFit()
        
            .frame(width: 22)
            .padding(.leading)
            .padding(.top, 14)
        
            .foregroundStyle(
                {
                    switch researchType {
                    case .completed:
                        return Color.green
                    case .locked:
                        return Color.red
                    case .less:
                        return Color.yellow
                    case .none:
                        return Color.red
                    }
                }()
            )
    }
}

#Preview {
    ParameterRow(title: "Description", content: "Description content", contentArray: ["One Hour", "Three Hours"], trailingContent: "57%", researchType: .completed)
}
