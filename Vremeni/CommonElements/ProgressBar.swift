//
//  ProgressBar.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct ProgressBar: View {
    
    private let height: CGFloat
    private let percent: CGFloat
    private let color: Color
    
    @State private var width: CGFloat = 0
    
    init(height: CGFloat = 20, percent: CGFloat = 0, color: Color = .orange) {
        self.height = height
        self.percent = percent
        self.color = color
    }
    
    var body: some View {
        LazyVStack(spacing: 0) {
            progressBar
            GeometryReader { reader in
                HStack {}
                    .onAppear {
                        width = reader.size.width
                    }
            }
        }
    }
    
    private var progressBar: some View {
        let multiplier = width / 100
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(height: height)
                .foregroundStyle(Color.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: percent * multiplier, height: height)
                .foregroundStyle(color)
                .animation(.linear, value: percent)
        }
    }
}

#Preview {
    ProgressBar(percent: 60)
}
