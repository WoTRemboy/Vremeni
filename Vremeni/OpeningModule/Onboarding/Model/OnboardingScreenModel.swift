//
//  OnboardingScreenModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import SwiftUI

struct OnboardingStep {
    let name: String
    let description: String
    let image: Image
}

extension OnboardingStep {
    static func stepsSetup() -> [OnboardingStep] {
        let first = OnboardingStep(name: Texts.OnboardingPage.firstTitle,
                                   description: Texts.OnboardingPage.firstDescription,
                                   image: .ProfilePage.about)
        
        let second = OnboardingStep(name: Texts.OnboardingPage.secondTitle,
                                    description: Texts.OnboardingPage.secondDescription,
                                    image: .ProfilePage.appearance)
        
        let third = OnboardingStep(name: Texts.OnboardingPage.thirdTitle,
                                   description: Texts.OnboardingPage.thirdDescription,
                                   image: .ProfilePage.language)
        
        let fourth = OnboardingStep(name: Texts.OnboardingPage.fourthTitle,
                                    description: Texts.OnboardingPage.fourthDescription,
                                    image: .ProfilePage.balance)
        
        return [first, second, third, fourth]
    }
}


enum OnboardingButtonType {
    case nextPage
    case getStarted
}
