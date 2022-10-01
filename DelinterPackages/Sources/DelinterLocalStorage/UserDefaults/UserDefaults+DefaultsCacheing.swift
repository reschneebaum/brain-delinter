import Combine
import Foundation

extension UserDefaults: DefaultsCacheing {
    @objc public var startTime: Date? {
        get {
            object(forKey: DefaultsKey.startTime.rawValue) as? Date
        }
        set {
            set(newValue, forKey: DefaultsKey.startTime.rawValue)
        }
    }
    
    @objc public var duration: Int {
        get {
            object(forKey: DefaultsKey.duration.rawValue) as? Int ?? Constants.defaultDuration
        }
        set {
            setValue(newValue, forKey: DefaultsKey.duration.rawValue)
        }
    }
    
    @objc public var allowSnooze: Bool {
        get {
            bool(forKey: DefaultsKey.snooze.rawValue)
        }
        set {
            set(newValue, forKey: DefaultsKey.snooze.rawValue)
        }
    }
    
    @objc public var showCompleted: Bool {
        get {
            object(forKey: DefaultsKey.showCompleted.rawValue) as? Bool ?? true
        }
        set {
            set(newValue, forKey: DefaultsKey.showCompleted.rawValue)
        }
    }
    
    public var startTimePublisher: AnyPublisher<Date?, Never> {
        publisher(for: \.startTime).removeDuplicates().eraseToAnyPublisher()
    }
    
    public var durationPublisher: AnyPublisher<Int, Never> {
        publisher(for: \.duration).removeDuplicates().eraseToAnyPublisher()
    }
    
    public var allowSnoozePublisher: AnyPublisher<Bool, Never> {
        publisher(for: \.allowSnooze).removeDuplicates().eraseToAnyPublisher()
    }
    
    public var showCompletedPublisher: AnyPublisher<Bool, Never> {
        publisher(for: \.showCompleted).removeDuplicates().eraseToAnyPublisher()
    }
    
    public func clearDefaults() {
        removeObject(forKey: DefaultsKey.duration.rawValue)
        removeObject(forKey: DefaultsKey.startTime.rawValue)
        removeObject(forKey: DefaultsKey.snooze.rawValue)
        removeObject(forKey: DefaultsKey.showCompleted.rawValue)
    }
    
    public func updateValue<ValueType>(_ value: ValueType, for key: DefaultsKey) {
        switch key {
        case .startTime:
            startTime = value as? Date
        case .duration:
            duration = value as? Int ?? Constants.defaultDuration
        case .snooze:
            allowSnooze = value as? Bool ?? false
        case .showCompleted:
            showCompleted = value as? Bool ?? false
        }
    }
}

extension Date {
    var components: DateComponents {
        Calendar.current.dateComponents([.hour, .minute], from: self)
    }
}

private enum Constants {
    static let defaultDuration = 20
}
