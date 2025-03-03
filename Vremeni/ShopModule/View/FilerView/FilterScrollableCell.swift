//
//  FilterScrollableCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 2/12/25.
//

import SwiftUI

struct FilterScrollableCell: View {
        
    private let selected: Bool
    private let rarity: Rarity
    private let namespace: Namespace.ID
    
    init(rarity: Rarity,
         selected: Bool,
         namespace: Namespace.ID) {
        self.rarity = rarity
        self.selected = selected
        self.namespace = namespace
    }
    
    internal var body: some View {
        if selected {
            selectedCell
        } else {
            miniCell
        }
    }
    
    private var miniCell: some View {
        Rectangle()
            .foregroundStyle(Color.BackColors.backSystem)
        
            .frame(width: 50, height: 40)
            .clipShape(.rect(cornerRadius: 18))
            
            .overlay {
                rarity.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 17)
            }
            .transition(.blurReplace)
    }
    
    private var selectedCell: some View {
        Rectangle()
            .foregroundStyle(rarity.color)
        
            .frame(width: 170, height: 40)
            .clipShape(.rect(cornerRadius: 18))
        
            .overlay {
                selectedCellContent
            }
            .transition(.blurReplace)
    }
    
    private var selectedCellContent: some View {
        HStack(spacing: 6) {
            rarity.whiteImage
                .resizable()
                .scaledToFit()
                .frame(width: 17, height: 17)
            
            Text(rarity.name)
                .font(.mediumBody())
                .foregroundStyle(Color.LabelColors.labelWhite)
        }
    }
}

#Preview {
    FilterScrollableCell(rarity: .common,
                         selected: true,
                         namespace: Namespace().wrappedValue)
}
