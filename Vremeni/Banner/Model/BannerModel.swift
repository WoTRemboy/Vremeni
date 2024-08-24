//
//  BannerModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/17/24.
//

import SwiftUI

enum BannerType {
    internal var id: Self { self }
    case added(message: String)
    case archived(message: String)
    case ready(message: String)
    case reset(message: String)
    
    internal var image: Image {
        switch self {
        case .added:
            Image.Banner.added
        case .archived:
            Image.Banner.archived
        case .ready:
            Image.Banner.ready
        case .reset:
            Image.Banner.reset
        }
    }
    
    internal var message: String {
        switch self {
        case let .added(message), let .archived(message), let .ready(message), let .reset(message: message):
            return message
        }
    }
}
