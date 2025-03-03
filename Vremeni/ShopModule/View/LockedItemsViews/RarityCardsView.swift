//
//  RarityGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 2/24/25.
//

import SwiftUI

struct RarityCardsView: View {
    internal var body: some View {
        content
    }
    
    private var content: some View {
        Rectangle()
            .foregroundStyle(Color.clear)
            .frame(maxHeight: .infinity)
            .anchorPreference(
                key: RarityCardRectKey.self,
                value: .bounds) { anchor in
                    return [Texts.PreferenceKey.cardRect : anchor]
                }
    }
}

#Preview {
    RarityCardsView()
}
