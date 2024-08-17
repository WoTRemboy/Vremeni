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
    
    internal var backgroundColor: Color {
        switch self {
        case .added:
            Color.yellow
        case .archived:
            Color.red
        case .ready:
            Color.green
        }
    }
    
    internal var image: Image {
        switch self {
        case .added:
            Image.Banner.added
        case .archived:
            Image.Banner.archived
        case .ready:
            Image.Banner.ready
        }
    }
    
    internal var message: String {
        switch self {
        case let .added(message), let .archived(message), let .ready(message):
            return message
        }
    }
}
