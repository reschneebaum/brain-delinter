import UserNotifications

extension UNNotificationRequest {
    /// Creates a notification request that schedules a `dailyStartTime` local notification at the given time, every day.
    static func dailyStartTime(at time: DateComponents) -> UNNotificationRequest {
        DailyNotification.dailyStartTime(time).request
    }
    
    /// Creates a notification request that schedules a `dailyEndTime` local notification at the given time, every day.
    static func dailyEndTime(at time: DateComponents) -> UNNotificationRequest {
        DailyNotification.dailyEndTime(time).request
    }
}
