//
//  DelinterNotifications.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Foundation
import UserNotifications

extension UNNotificationRequest {
    static func dailyStartTime(at time: DateComponents) -> UNNotificationRequest {
        DelinterNotification.dailyStartTime(time).request
    }
    static func dailyEndTime(at time: DateComponents) -> UNNotificationRequest {
        DelinterNotification.dailyEndTime(time).request
    }
}

private enum DelinterNotification {
    case dailyStartTime(DateComponents)
    case dailyEndTime(DateComponents)
    
    var request: UNNotificationRequest {
        .init(identifier: identifier, content: content, trigger: trigger)
    }
    
    private var identifier: String {
        UUID().uuidString
    }
    
    private var trigger: UNNotificationTrigger {
        switch self {
        case let .dailyStartTime(components), let .dailyEndTime(components):
            return UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        }
    }
    
    private var content: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        
        switch self {
        case .dailyStartTime:
            content.title = Localized.Notification.Start.title
            content.body = Localized.Notification.Start.body
            content.categoryIdentifier = Category.alarm.rawValue
            content.sound = .default
            content.interruptionLevel = .timeSensitive
            
        case .dailyEndTime:
            content.title = Localized.Notification.End.title
            content.body = Localized.Notification.End.body
            content.categoryIdentifier = Category.alarm.rawValue
            content.sound = .default
            content.interruptionLevel = .timeSensitive
        }
        
        return content
    }
    
    enum Category: String {
        case alarm
    }
}
