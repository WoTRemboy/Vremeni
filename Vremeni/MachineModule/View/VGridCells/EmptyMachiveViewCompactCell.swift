//
//  EmptyMachiveViewCompactCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/14/24.
//

import SwiftUI

struct EmptyMachiveViewCompactCell: View {
    internal var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                image
                    .frame(width: reader.size.width, alignment: .center)
            }
            .frame(height: reader.size.height)
            .background(Color.BackColors.backElevated)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.1), radius: 20)
        }
        .frame(height: 100)
    }
    
    private var image: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
            Image(systemName: "arrow.up.to.line.compact")
                .resizable()
                .scaledToFit()
                .padding(8)
                .foregroundStyle(Color.green)
        }
        .frame(width: 45, height: 30)
        .foregroundStyle(Color.Tints.green)
    }
}

#Preview {
    EmptyMachiveViewCompactCell()
}
