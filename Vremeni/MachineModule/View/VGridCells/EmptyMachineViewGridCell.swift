//
//  EmptyMachineViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/2/24.
//

import SwiftUI

struct EmptyMachineViewGridCell: View {
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                image
                    .frame(width: reader.size.width, alignment: .center)
                title
            }
            .frame(height: reader.size.height)
            .background(Color.BackColors.backElevated)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 20)
        }
        .frame(height: 220)
    }
    
    private var image: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
            Image(systemName: "arrow.up.to.line.compact")
                .resizable()
                .scaledToFit()
                .padding(20)
                .foregroundStyle(Color.green)
        }
        .frame(width: 70, height: 70)
        .foregroundStyle(Color.Tints.green)
    }
    
    private var title: some View {
        Text(Texts.MachinePage.emptyTitle)
            .font(.emptyCellTitle())
            .foregroundStyle(Color.LabelColors.labelPrimary)
    }
}

#Preview {
    EmptyMachineViewGridCell()
}
