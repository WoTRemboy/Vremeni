//
//  BannerModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/17/24.
//

import SwiftUI

enum BannerType {
    internal var id: Self { self }
    case added(message: String, isPersistent: Bool)
    case archived(message: String, isPersistent: Bool)
    case ready(message: String, isPersistent: Bool)
    
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
    
    internal var imageName: String {
        switch self {
        case .added:
            "exclamationmark.triangle.fill"
        case .archived:
            "xmark.circle.fill"
        case .ready:
            "checkmark.circle.fill"
        }
    }
    
    internal var message: String {
        switch self {
        case let .added(message, _), let .archived(message, _), let .ready(message, _):
            return message
        }
    }
    
    internal var isPersistent: Bool {
        switch self {
        case let .added(_, isPersistent), let .archived(_, isPersistent), let .ready(_, isPersistent):
            return isPersistent
        }
    }
}
