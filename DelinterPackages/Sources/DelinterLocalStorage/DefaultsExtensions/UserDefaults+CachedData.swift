import Foundation

public extension UserDefaults {
    var isStartTimeSet: Bool {
        scheduledStartTime != nil
    }
    
    var startTimeComponents: DateComponents? {
        scheduledStartTime?.components
    }
    
    var endTimeComponents: DateComponents? {
        endTime?.components
    }
    
    @objc var scheduledStartTime: Date? {
        get {
            object(forKey: Keys.startTime) as? Date
        }
        set {
            set(newValue, forKey: Keys.startTime)
        }
    }
    
    @objc var duration: Int {
        get {
            object(forKey: Keys.duration) as? Int ?? Constants.defaultDuration
        }
        set {
            setValue(newValue, forKey: Keys.duration)
        }
    }
    
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
            object(forKey: Keys.showCompleted) as? Bool ?? true
        }
        set {
            set(newValue, forKey: Keys.showCompleted)
        }
    }
    
    private var endTime: Date? {
        guard let scheduledStartTime else { return nil }
        let duration = duration > 0 ? duration : Constants.defaultDuration
        return Calendar.current.date(byAdding: .minute, value: duration, to: scheduledStartTime)
    }
    
    func clearDefaults() {
        removeObject(forKey: Keys.duration)
        removeObject(forKey: Keys.startTime)
        removeObject(forKey: Keys.snooze)
        removeObject(forKey: Keys.showCompleted)
    }
}

private extension Date {
    var components: DateComponents {
        Calendar.current.dateComponents([.hour, .minute], from: self)
    }
}

private enum Constants {
    static let defaultDuration = 20
}

private enum Keys {
    static let startTime = "ScheduledStartTime"
    static let duration = "BetweenAlarmInterval"
    static let snooze = "AllowSnooze"
    static let showCompleted = "ShowCompleted"
}
