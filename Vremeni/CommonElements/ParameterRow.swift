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
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    internal var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .padding(.horizontal)
                .frame(height: 1)
                .foregroundStyle(Color.LabelColors.labelDisable)
            
            Text(title)
                .font(.headline())
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top, 14)
            
            Text(content)
                .font(.subhead())
                .foregroundStyle(Color.LabelColors.labelSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top, 5)
        }
    }
}

#Preview {
    ParameterRow(title: "Description", content: "Description content")
}
