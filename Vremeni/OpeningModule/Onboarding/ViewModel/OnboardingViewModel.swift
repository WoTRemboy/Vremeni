//
//  OnboardingViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import Foundation
import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    @AppStorage(Texts.UserDefaults.skipOnboarding) var skipOnboarding: Bool = false
    @Published internal var steps = OnboardingStep.stepsSetup()
    @Published internal var currentStep = 0
    
    // MARK: - Computed Properties
    
    /// Pages for the onboarding process.
    internal var pages: [Int] {
        Array(0..<steps.count)
    }
    
    internal var buttonType: OnboardingButtonType {
        if currentStep < steps.count - 1 {
            return .nextPage
        } else {
            return .getStarted
        }
    }
    
    internal func setupCurrentStep(newValue: Int) {
        currentStep = newValue
    }
    
    internal func transferToMainPage() {
        skipOnboarding.toggle()
    }
}
