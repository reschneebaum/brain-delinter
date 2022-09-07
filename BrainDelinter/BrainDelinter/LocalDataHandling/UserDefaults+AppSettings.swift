//
//  UserDefaults+AppSettings.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Foundation

extension UserDefaults {
    @objc var allowSnooze: Bool {
        get {
            bool(forKey: Keys.snooze)
        }
        set {
            set(newValue, forKey: Keys.snooze)
        }
    }
    
    @objc var showCompleted: Bool {
        get {
            bool(forKey: Keys.showCompleted)
        }
        set {
            set(newValue, forKey: Keys.showCompleted)
        }
    }
}

private enum Keys {
    static let snooze = "AllowSnooze"
    static let showCompleted = "ShowCompleted"
}
