//
//  ColorExtension.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 24.07.2024.
//

import SwiftUI

extension Color {
    enum BackColors {
        static let backElevated = Color("BackElevated")
        static let backiOSPrimary = Color("BackiOSPrimary")
        static let backPrimary = Color("BackPrimary")
        static let backSecondary = Color("BackSecondary")
        static let backSplash = Color("BackSplash")
        static let backDefault = Color("BackDefault")
    }
    
    enum LabelColors {
        static let labelDisable = Color("LabelDisable")
        static let labelPrimary = Color("LabelPrimary")
        static let labelSecondary = Color("LabelSecondary")
        static let labelTertiary = Color("LabelTertiary")
    }
    
    enum SupportColors {
        static let supportNavBar = Color("SupportNavBar")
        static let supportOverlay = Color("SupportOverlay")
        static let supportSegmented = Color("SupportSegmented")
    }
    
    enum IconColors {
        static let blue = Color("IconBlue")
    }
    
    enum Tints {
        static let orange = Color("OrangeTint")
        static let green = Color("GreenTint")
        static let blue = Color("BlueTint")
    }
}
