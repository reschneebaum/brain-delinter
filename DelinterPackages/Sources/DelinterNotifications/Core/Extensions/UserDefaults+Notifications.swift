import Foundation

public extension UserDefaults {
    var hasScheduledNotifications: Bool {
        scheduledStartTime != nil && duration > 0
    }
    
    var startTimeComponents: DateComponents? {
        guard let startTime = scheduledStartTime else {
            return nil
        }
        return Calendar.current.dateComponents([.hour, .minute], from: startTime)
    }
    
    var endTimeComponents: DateComponents? {
        guard let startTimeComponents = startTimeComponents, duration > 0 else {
            return nil
        }
        var endTimeComponents = DateComponents()
        endTimeComponents.hour = startTimeComponents.hour ?? 0
        endTimeComponents.minute = startTimeComponents.minute ?? 0 + duration
        return endTimeComponents
    }
    
    @objc var scheduledStartTime: Date? {
        get {
            object(forKey: Keys.startTime) as? Date
        }
        set {
            guard let newValue = newValue else { return }
            set(newValue, forKey: Keys.startTime)
        }
    }
    
    @objc var duration: Int {
        get {
            integer(forKey: Keys.duration)
        }
        set {
            guard newValue > 0 else { return }
            set(newValue, forKey: Keys.duration)
        }
    }
}

private enum Keys {
    static let startTime = "ScheduledStartTime"
    static let endTime = "ScheduledEndTime"
    static let duration = "BetweenAlarmInterval"
}
