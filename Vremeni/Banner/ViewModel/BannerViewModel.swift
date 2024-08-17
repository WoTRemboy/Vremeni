//
//  BannerViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/17/24.
//

import SwiftUI

final class BannerViewModel: ObservableObject {
    
    @Published internal var isAnimating = false
    @Published internal var dragOffSet: CGSize = .zero
    
    @Published internal var bannerType: BannerType? {
        didSet {
            withAnimation {
                switch bannerType {
                case .none:
                    isAnimating = false
                case .some:
                    isAnimating = true
                }
            }
        }
    }
    
    internal let maxDragOffsetHeight: CGFloat = -50.0
    
    internal func setBanner(banner: BannerType) {
        withAnimation {
            self.bannerType = bannerType
        }
    }
    
    internal func removeBanner() {
        withAnimation {
            self.bannerType = nil
            self.isAnimating = false
            self.dragOffSet = .zero
        }
    }
    
    internal func setupPreview() {
        
    }
}
