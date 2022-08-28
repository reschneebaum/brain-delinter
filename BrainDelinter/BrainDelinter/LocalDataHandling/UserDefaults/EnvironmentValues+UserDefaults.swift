//
//  EnvironmentValues+UserDefaults.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    /// The current environment's user defaults
    /// - Note: the value only changes in unit tests and previews — i.e., when we shouldn't use `.standard`
    var userDefaults: UserDefaults {
        get {
            self[UserDefaultsKey.self]
        }
        set {
            self[UserDefaultsKey.self] = newValue
        }
    }
}

private struct UserDefaultsKey: EnvironmentKey {
    static var defaultValue: UserDefaults = .standard
}
