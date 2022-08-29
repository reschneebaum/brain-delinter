//
//  UserDefaults+AppSettings.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Foundation

extension UserDefaults {
    var allowSnooze: Bool {
        get {
            bool(forKey: Keys.snooze)
        }
        set {
            set(newValue, forKey: Keys.snooze)
        }
    }
}

private enum Keys {
    static let snooze = "AllowSnooze"
}
