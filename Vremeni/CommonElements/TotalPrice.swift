//
//  TotalPrice.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import SwiftUI

struct TotalPrice: View {
    
    private var price: String
    
    init(price: Float) {
        self.price = String(Int(price))
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
            Image.ShopPage.vCoin
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            Text(price)
                .font(.totalPrice())
                .foregroundStyle(Color.LabelColors.labelPrimary)
        }
    }
    
}

#Preview {
    TotalPrice(price: 100)
}
