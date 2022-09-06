//
//  UserDefaults+Mocked.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

// FIXME: Figure out why #if DEBUG doesn't work here

//#if DEBUG
import Foundation

extension UserDefaults {
    static var mocked: UserDefaults = {
        let suiteName = "MockUserDefaults"
        // Clear out the persistent domain in case an old defaults instance was created with the same suite name.
        UserDefaults().removePersistentDomain(forName: suiteName)
        
        // Create and unwrap a new, clean instance.
        guard let defaults = UserDefaults(suiteName: suiteName) else {
            fatalError("Failed to initialize mock user defaults")
        }
        return defaults
    }()
}
//#endif
