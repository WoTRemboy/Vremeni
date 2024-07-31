//
//  ProfileViewModel.swift
//  Vremeni
//
//  Created by Roman Tverdokhleb on 7/31/24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var version: String = String()
    
    init() {
        versionDetect()
    }
    
    internal func versionDetect() {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            version = "\(appVersion) \(Texts.ProfilePage.release) \(buildVersion)"
        }
    }
    
}
