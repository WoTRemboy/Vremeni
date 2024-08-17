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
        VStack {
            Group {
                bannerContent
                    .onAppear {
                        guard !banner.isPersistent else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                viewModel.isAnimating = false
                                viewModel.bannerType = nil
                            }
                        }
                    }
                    .offset(y: viewModel.dragOffSet.height)
                    .opacity(viewModel.isAnimating ? max(0, (1.0 - Double(viewModel.dragOffSet.height) / viewModel.maxDragOffsetHeight)) : 0)
                
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.height < 0 {
                                    viewModel.dragOffSet = gesture.translation
                                }
                            }
                            .onEnded { value in
                                if viewModel.dragOffSet.height < -20 {
                                    withAnimation{
                                        viewModel.removeBanner()
                                    }
                                } else {
                                    viewModel.dragOffSet = .zero
                                }
                            }
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal)
            }
        }
    }
    
    private var bannerContent: some View {
        HStack(spacing: 10) {
            Image(systemName: banner.imageName)
                .padding(5)
                .background(banner.backgroundColor)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.2), radius: 3.0, x: -3, y:4)
            
            VStack(spacing: 5) {
                Text(banner.message)
                    .foregroundColor(Color.LabelColors.labelPrimary)
                    .font(.subhead())
                    .multilineTextAlignment(.leading)
                    .lineLimit(showAllText ? nil : 2)
            }
            banner.isPersistent ?
                Button {
                    withAnimation{
                        viewModel.removeBanner()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .shadow(color: .black.opacity(0.2), radius: 3.0, x: 3, y:4)
                : nil
        }
        .foregroundColor(.white)
        .padding(8)
        .padding(.trailing, 2)
        .background(banner.backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 3.0, x: -2, y:2)
    }
}

#Preview {
    let environmentObject = BannerViewModel()
    return BannerView(type: .added(message: "Notification message", isPersistent: true))
        .environmentObject(environmentObject)
}
