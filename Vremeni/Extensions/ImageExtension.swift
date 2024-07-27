//
//  ImageExtension.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI

extension Image {
    enum ShopPage {
        static let vCoin = Image("VCoin")
    }
    
    enum TabBar {
        static let shop = Image(systemName: "creditcard.and.123")
        static let machine = Image(systemName: "clock.arrow.2.circlepath")
        static let inventory = Image(systemName: "amplifier")
        static let profile = Image(systemName: "person")
    }
    
    enum Placeholder {
        static let placeholder1to1 = Image("Placeholder1to1")
    }
}
