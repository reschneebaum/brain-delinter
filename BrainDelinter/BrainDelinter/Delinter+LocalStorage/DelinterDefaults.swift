//
//  UserDefaults+AppSettings.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Foundation
import DelinterLocalStorage

enum LocalData {
    static let defaults: DefaultsCacheing = {
        if shouldUseMock {
            return MockUserDefaults()
        } else {
           return UserDefaults.standard
        }
    }()
    
    static let userDefaults: UserDefaults = {
        shouldUseMock ? .mocked : .standard
    }()
    
    private static let shouldUseMock: Bool = {
        #if DEBUG
            AppConstants.isXcodePreview || AppConstants.isRunningTests
        #else
            false
        #endif
    }()
}
