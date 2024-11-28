//
//  IconChangerViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/28/24.
//

import Foundation
import UIKit

final class IconChangerViewModel: ObservableObject, Equatable {
    @Published internal var appIcon: Icon = .primary
    
    init() {
        let iconName = UIApplication.shared.alternateIconName

        if let iconName {
            appIcon = Icon(rawValue: iconName) ?? Icon.primary
        } else {
            appIcon = .primary
        }
    }

    static func == (lhs: IconChangerViewModel, rhs: IconChangerViewModel) -> Bool {
        return lhs.appIcon == rhs.appIcon
    }

    internal func setAlternateAppIcon(icon: Icon) {
            let iconName: String? = (icon != .primary) ? icon.rawValue : nil

            guard UIApplication.shared.alternateIconName != iconName else { return }

            UIApplication.shared.setAlternateIconName(iconName) { (error) in
                if let error = error {
                    print("Failed request to update the app’s icon: \(error)")
                }
            }

            appIcon = icon
    }
}
