//
//  OnboardingViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 9/1/24.
//

import Foundation
import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    @Published internal var steps = OnboardingStep.stepsSetup()
    @Published internal var currentStep = 0
    
    internal var stepsCount: Int {
        steps.count
    }
    
    internal var buttonType: OnboardingButtonType {
        if currentStep < steps.count - 1 {
            return .nextPage
        } else {
            return .getStarted
        }
    }
    
    internal func nextStep() {
        withAnimation(.easeInOut) {
            currentStep += 1
        }
    }
    
    internal func skipSteps() {
        withAnimation(.easeInOut) {
            currentStep = steps.count - 1
        }
    }
    
    internal func getStarted() {
        
    }
}
