//
//  FilterScrollableCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 2/12/25.
//

import SwiftUI

struct FilterScrollableCell: View {
        
    private let selected: Bool
    private let name: String
    private let namespace: Namespace.ID
    
    init(name: String, selected: Bool, namespace: Namespace.ID) {
        self.name = name
        self.selected = selected
        self.namespace = namespace
    }
    
    internal var body: some View {
        nameLabel
            .background(alignment: .bottom) {
                if selected {
                    underline
                        .offset(y: 5)
                }
            }
    }
    
    private var nameLabel: some View {
        Text(name)
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(selected ? Color.LabelColors.labelPrimary : Color.LabelColors.labelSecondary)
            .frame(maxWidth: .infinity)
    }
    
    private var underline: some View {
        Rectangle()
            .foregroundStyle(Color.LabelColors.labelPrimary)
            .matchedGeometryEffect(
                id: Texts.NamespaceID.selectedTab,
                in: namespace)
            .frame(maxWidth: .infinity)
            .frame(height: 2)
    }
}

#Preview {
    FilterScrollableCell(name: "Active",
                         selected: true,
                         namespace: Namespace().wrappedValue)
}
