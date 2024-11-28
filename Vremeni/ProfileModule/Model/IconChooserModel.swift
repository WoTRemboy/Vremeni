//
//  IconChooserModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 11/28/24.
//

enum Icon: String, CaseIterable, Identifiable {
    case primary = "AppIcon"
    case premium = "AppIconPremium"

    var id: String { self.rawValue }
}
