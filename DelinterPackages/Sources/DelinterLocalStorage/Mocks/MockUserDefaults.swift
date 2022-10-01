import Combine
import Foundation

public class MockUserDefaults: DefaultsCacheing {
    public var startTime: Date?
    public var duration: Int
    public var allowSnooze: Bool
    public var showCompleted: Bool
    
    public var startTimePublisher: AnyPublisher<Date?, Never> {
        Just(startTime).eraseToAnyPublisher()
    }
    public var durationPublisher: AnyPublisher<Int, Never> {
        Just(duration).eraseToAnyPublisher()
    }
    public var allowSnoozePublisher: AnyPublisher<Bool, Never> {
        Just(allowSnooze).eraseToAnyPublisher()
    }
    public var showCompletedPublisher: AnyPublisher<Bool, Never> {
        Just(showCompleted).eraseToAnyPublisher()
    }
    
    public init(startTime: Date? = nil, duration: Int = 20, allowSnooze: Bool = false, showCompleted: Bool = true) {
        self.startTime = startTime
        self.duration = duration
        self.allowSnooze = allowSnooze
        self.showCompleted = showCompleted
    }
    
    public func clearDefaults() {
        startTime = nil
        duration = 20
        allowSnooze = false
        showCompleted = true
    }
    
    public func updateValue<ValueType>(_ value: ValueType, for key: DefaultsKey) {
        switch key {
        case .startTime:
            startTime = value as? Date
        case .duration:
            duration = value as? Int ?? 20
        case .snooze:
            guard let snooze = value as? Bool else {
                return
            }
            allowSnooze = snooze
        case .showCompleted:
            guard let show = value as? Bool else {
                return
            }
            showCompleted = show
        }
    }
}
