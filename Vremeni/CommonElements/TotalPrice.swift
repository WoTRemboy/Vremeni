//
//  TotalPrice.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import SwiftUI

struct TotalPrice: View {
    
    private var price: String
    private let type: TotalType
    
    init(price: Float, type: TotalType = .price) {
        self.price = String(Int(price))
        self.type = type
    }
    
    internal var body: some View {
        VStack(spacing: 2) {
            Text(Texts.TotalPrice.total)
                .font(.footnote())
                .foregroundStyle(Color.LabelColors.labelSecondary)
            priceRow
        }
    }
    
    private var priceRow: some View {
        HStack(spacing: 10) {
            image
                .resizable()
                .scaledToFit()
                .fontWeight(.heavy)
                .foregroundStyle(Color.white, Color.IconColors.blue)
                .frame(width: 25)
            Text(price)
                .font(.totalPrice())
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
    }
    
    private var image: Image {
        switch type {
        case .price:
            Image.ShopPage.vCoin
        case .count:
            Image.InventoryPage.count
        }
    }
    
}

enum TotalType {
    case price
    case count
}

#Preview {
    TotalPrice(price: 100, type: .count)
}
