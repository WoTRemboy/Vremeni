//
//  SectionHeader.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/9/24.
//

import SwiftUI

struct SectionHeader: View {
    
    private let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    internal var body: some View {
        Text(text)
            .font(.segmentTitle())
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SectionHeader("Section Header")
}
