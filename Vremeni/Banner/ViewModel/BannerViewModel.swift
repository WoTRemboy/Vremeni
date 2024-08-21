//
//  BannerViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/17/24.
//

import SwiftUI

final class BannerViewModel: ObservableObject {
    
    private var isShowingAvailable = true
    
    @Published internal var isAnimating = false
    @Published internal var bannerOffset: CGFloat = -200.0

    @Published internal var bannerType: BannerType? {
        didSet {
            if bannerType != nil {
                withAnimation {
                    showBanner()
                }
            }
        }
    }
        
    private func showBanner() {
        guard isShowingAvailable else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.spring()) {
                self.bannerOffset = 0
                self.isAnimating = true
                self.isShowingAvailable = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.hideBanner()
        }
    }
    
    private func hideBanner() {
        withAnimation(.spring()) {
            bannerOffset = -200
            isAnimating = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.bannerType = nil
            self.isShowingAvailable = true
        }
    }
    
    internal func setBanner(banner: BannerType) {
        self.bannerType = banner
    }
    
    internal func removeBanner() {
        hideBanner()
    }
}
