//
//  NewSlotMachineViewGridCell.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/2/24.
//

import SwiftUI

struct NewSlotMachineViewGridCell: View {
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 16) {
                image
                    .frame(width: reader.size.width, alignment: .center)
            }
            .frame(height: reader.size.height)
            .background(Color.BackColors.backDefault)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.Tints.orange, lineWidth: 4)
            )
        }
        .frame(height: 100)
    }
    
    private var image: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .padding(8)
                .foregroundStyle(Color.blue)
        }
        .frame(width: 45, height: 30)
        .foregroundStyle(Color.Tints.blue)
    }
}

#Preview {
    NewSlotMachineViewGridCell()
}
