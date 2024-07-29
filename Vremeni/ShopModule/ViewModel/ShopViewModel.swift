//
//  ShopViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import Foundation
import CoreData

final class ShopViewModel: ObservableObject {
    
    @Published private(set) var items = ConsumableItem.itemsMockConfig()
    
}
