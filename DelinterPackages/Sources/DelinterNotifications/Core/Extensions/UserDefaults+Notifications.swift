import Foundation

public extension UserDefaults {
    var isStartTimeSet: Bool {
        scheduledStartTime != nil
    }
    
    var startTimeComponents: DateComponents? {
        scheduledStartTime?.dateComponents
    }
    
    var endTimeComponents: DateComponents? {
        endTime?.dateComponents
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
    
    private var endTime: Date? {
        guard let scheduledStartTime else { return nil }
        return Calendar.current.date(byAdding: .minute, value: duration, to: scheduledStartTime)
    }
}

extension Date {
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.hour, .minute], from: self)
    }
}

private enum Keys {
    static let startTime = "ScheduledStartTime"
    static let endTime = "ScheduledEndTime"
    static let duration = "BetweenAlarmInterval"
}
