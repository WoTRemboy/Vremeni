//
//  ContentLabels.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 8/27/24.
//

import Foundation

final class Content {
    enum Common {
        static let oneMinuteTitle = "ContentCommonOneMinuteTitle"
        static let oneMinuteDescription = "ContentCommonOneMinuteDescription"
        
        static let threeMinutesTitle = "ContentCommonThreeMinutesTitle"
        static let threeMinutesDescription = "ContentCommonThreeMinutesDescription"
    }
    
    enum Uncommon {
        static let fiveMinutesTitle = "ContentCommonFiveMinutesTitle"
        static let fiveMinutesDescription = "ContentCommonFiveMinutesDescription"
        
        static let sevenMinutesTitle = "ContentCommonSevenMinutesTitle"
        static let sevenMinutesDescription = "ContentCommonSevenMinutesDescription"
    }
    
    enum Rare {
        static let tenMinutesTitle = "ContentCommonTenMinutesTitle"
        static let tenMinutesDescription = "ContentCommonTenMinutesDescription"
    }
}
