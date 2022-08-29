//
//  DelinterNotifications.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Foundation
import UserNotifications

enum DailyNotification {
    case dailyStartTime(DateComponents)
    case dailyEndTime(DateComponents)
    
    var request: UNNotificationRequest {
        .init(identifier: contentConfig.rawValue, content: contentConfig.content, trigger: trigger)
    }
    
    private var contentConfig: NotificationConfig {
        switch self {
        case .dailyStartTime: return .startTime
        case .dailyEndTime: return .endTime
        }
    }
    
    private var trigger: UNNotificationTrigger {
        switch self {
        case let .dailyStartTime(components), let .dailyEndTime(components):
            return UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        }
    }
}

enum NotificationConfig: String, CaseIterable {
    case startTime = "DailyStartTimeNotification"
    case endTime = "DailyEndTimeNotification"
    
    var content: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = category
        content.sound = sound
        content.interruptionLevel = interruptionLevel
        return content
    }
    
    private var title: String {
        switch self {
        case .startTime:
            return Localized.Alarm.Start.title
        case .endTime:
            return Localized.Alarm.End.title
        }
    }
    private var body: String {
        switch self {
        case .startTime:
            return Localized.Alarm.Start.body
        case .endTime:
            return Localized.Alarm.End.body
        }
    }
    private var category: String {
        Category.alarm.rawValue
    }
    private var sound: UNNotificationSound {
        .default
    }
    private var interruptionLevel: UNNotificationInterruptionLevel {
        .timeSensitive
    }
    
    private enum Category: String {
        case alarm
    }
}
