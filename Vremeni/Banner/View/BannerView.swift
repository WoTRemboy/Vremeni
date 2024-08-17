//
//  BannerView.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/17/24.
//

import SwiftUI

struct BannerView: View {
    
    @EnvironmentObject private var viewModel: BannerViewModel
    @State private var showAllText = false
    private let banner: BannerType
    
    init(type: BannerType) {
        self.banner = type
    }
    
    internal var body: some View {
        bannerContent
            .offset(y: viewModel.bannerOffset)
            .opacity(viewModel.isAnimating ? 1.0 : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
    }
    
    private var bannerContent: some View {
        HStack(spacing: 16) {
            banner.image
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .background(Color.red)
                .cornerRadius(5)
            
            VStack(spacing: 5) {
                Text(banner.message)
                    .foregroundColor(Color.LabelColors.labelPrimary)
                    .font(.body())
                    .multilineTextAlignment(.leading)
                    .lineLimit(showAllText ? nil : 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.BackColors.backSplash)
        .cornerRadius(10)
    }
}

#Preview {
    let environmentObject = BannerViewModel()
    return BannerView(type: .added(message: "Notification message"))
        .environmentObject(environmentObject)
}
