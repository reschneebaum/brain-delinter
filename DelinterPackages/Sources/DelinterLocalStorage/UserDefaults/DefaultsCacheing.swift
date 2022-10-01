import Combine
import Foundation

public protocol DefaultsCacheing {
    var hasStartTime: Bool { get }
    var startTimeComponents: DateComponents? { get }
    var endTimeComponents: DateComponents? { get }
    var startTime: Date? { get set }
    var duration: Int { get set }
    var allowSnooze: Bool { get set }
    var showCompleted: Bool { get set }
    
    var startTimePublisher: AnyPublisher<Date?, Never> { get }
    var durationPublisher: AnyPublisher<Int, Never> { get }
    var allowSnoozePublisher: AnyPublisher<Bool, Never> { get }
    var showCompletedPublisher: AnyPublisher<Bool, Never> { get }

    var defaultDuration: Int { get }
    
    func clearDefaults()
    func updateValue<ValueType>(_ value: ValueType, for key: DefaultsKey)
}

public extension DefaultsCacheing {
    var hasStartTime: Bool {
        startTime != nil
    }
    
    var startTimeComponents: DateComponents? {
        startTime?.components
    }
    
    var endTimeComponents: DateComponents? {
        guard let startTime else { return nil }
        let duration = duration > 0 ? duration : defaultDuration
        return Calendar.current.date(byAdding: .minute, value: duration, to: startTime)?.components
    }
    
    var defaultDuration: Int {
        20
    }
}

public enum DefaultsKey: String {
    case startTime = "ScheduledStartTime"
    case duration = "BetweenAlarmInterval"
    case snooze = "AllowSnooze"
    case showCompleted = "ShowCompleted"
}
