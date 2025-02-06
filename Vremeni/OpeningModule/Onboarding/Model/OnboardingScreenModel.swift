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
                                   image: .OnboardingPage.first)
        
        let second = OnboardingStep(name: Texts.OnboardingPage.secondTitle,
                                    description: Texts.OnboardingPage.secondDescription,
                                    image: .OnboardingPage.second)
        
        let third = OnboardingStep(name: Texts.OnboardingPage.thirdTitle,
                                   description: Texts.OnboardingPage.thirdDescription,
                                   image: .OnboardingPage.third)
        
        let fourth = OnboardingStep(name: Texts.OnboardingPage.fourthTitle,
                                    description: Texts.OnboardingPage.fourthDescription,
                                    image: .OnboardingPage.fourth)
        
        return [first, second, third, fourth]
    }
}


enum OnboardingButtonType {
    case nextPage
    case getStarted
}
