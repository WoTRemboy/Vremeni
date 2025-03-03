//
//  RarityCardRectKey.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 2/24/25.
//

import SwiftUI

struct RarityCardRectKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>],
                       nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
