//
//  ProgressBar.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 25.07.2024.
//

import SwiftUI

struct ProgressBar: View {
    
    private let width: CGFloat
    private let height: CGFloat
    private let percent: CGFloat
    private let ready: Bool
    
    init(width: CGFloat = 200, height: CGFloat = 20, percent: CGFloat = 0, ready: Bool = false) {
        self.width = width
        self.height = height
        self.percent = percent
        self.ready = ready
    }
    
    var body: some View {
        LazyVStack(spacing: 5) {
            timeProgressLabel
            progressBar
        }
    }
    
    private var timeProgressLabel: some View {
        HStack {
            Text(ready ? "\(Texts.ProgressBar.completed)" : "\(Texts.ProgressBar.progress): \(Int(percent))%")
                .padding(.leading)
            Spacer()
        }
    }
    
    private var progressBar: some View {
        let multiplier = width / 100
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: width, height: height)
                .foregroundStyle(Color.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: percent * multiplier, height: height)
                .foregroundStyle(ready ? Color.green : Color.orange)
                .animation(.linear, value: percent)
        }
    }
}

#Preview {
    ProgressBar(ready: false)
}
