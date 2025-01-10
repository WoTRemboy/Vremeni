//
//  TabRouter.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 1/10/25.
//

import SwiftUI

enum Tab: Hashable {
    case shop
    case machine
    case inventory
    case profile
}

final class TabRouter: ObservableObject {
    @Published var selectedTab: Tab = .shop
}
