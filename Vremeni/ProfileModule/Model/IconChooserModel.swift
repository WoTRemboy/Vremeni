//
//  IconChooserModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/28/24.
//

enum Icon: String, CaseIterable, Identifiable {
    case primary = "AppIcon"
    case beta = "AppIconBeta"
    case premium = "AppIconPremium"

    internal var id: String { self.rawValue }
    
    internal var name: String {
        switch self {
        case .primary:
            Texts.ProfilePage.defaultIcon
        case .beta:
            Texts.ProfilePage.beta
        case .premium:
            Texts.ProfilePage.premium
        }
    }
}
