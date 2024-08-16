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
        static let backPopup = Color("BackPopup")
        static let backDefault = Color("BackDefault")
    }
    
    enum LabelColors {
        static let labelDisable = Color("LabelDisable")
        static let labelDetails = Color("LabelDetails")
        static let labelPrimary = Color("LabelPrimary")
        static let labelSecondary = Color("LabelSecondary")
        static let labelTertiary = Color("LabelTertiary")
    }
    
    enum SupportColors {
        static let supportNavBar = Color("SupportNavBar")
        static let supportOverlay = Color("SupportOverlay")
        static let supportSegmented = Color("SupportSegmented")
        static let supportTextField = Color("SupportTextField")
    }
    
    enum RarityColors {
        static let common = Color("RarityCommon")
        static let uncommon = Color("RarityUncommon")
        static let rare = Color("RarityRare")
        static let epic = Color("RarityEpic")
        static let legendary = Color("RarityLegendary")
        static let mythic = Color("RarityMythic")
        static let exotic  = Color("RarityExotic")
        static let transcendent = Color("RarityTranscendent")
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
