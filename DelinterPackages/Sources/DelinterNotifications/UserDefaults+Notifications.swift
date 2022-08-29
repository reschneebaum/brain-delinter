//
//  File.swift
//  
//
//  Created by Rachel Schneebaum on 8/29/22.
//

import Foundation

public extension UserDefaults {
    var startTimeComponents: DateComponents? {
        guard let startTime = scheduledStartTime else {
            return nil
        }
        return Calendar.current.dateComponents([.hour, .minute], from: startTime)
    }
    
    var endTimeComponents: DateComponents? {
        guard let startTimeComponents = startTimeComponents, interval > 0 else {
            return nil
        }
        var endTimeComponents = DateComponents()
        endTimeComponents.hour = startTimeComponents.hour ?? 0
        endTimeComponents.minute = startTimeComponents.minute ?? 0 + interval
        return endTimeComponents
    }
    
    var scheduledStartTime: Date? {
        get {
            object(forKey: Keys.startTime) as? Date
        }
        set {
            set(newValue, forKey: Keys.startTime)
        }
    }
    
    var interval: Int {
        get {
            integer(forKey: Keys.interval)
        }
        set {
            guard newValue > 0 else { return }
            set(newValue, forKey: Keys.interval)
        }
    }
}

private enum Keys {
    static let startTime = "ScheduledStartTime"
    static let interval = "BetweenAlarmInterval"
}
