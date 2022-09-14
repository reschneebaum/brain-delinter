//
//  SettingsItem.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/26/22.
//

enum SettingsItem: String, CaseIterable {
    case alarmTime
    case snooze
    case duration
    
    var title: String {
        switch self {
        case .alarmTime:
            return Localized.Settings.Alarm.title
        case .snooze:
            return Localized.Settings.Snooze.title
        case .duration:
            return Localized.Settings.Duration.title
        }
    }
    
    var description: String {
        switch self {
        case .alarmTime:
            return Localized.Settings.Alarm.description
        case .snooze:
            return Localized.Settings.Snooze.description
        case .duration:
            return Localized.Settings.Duration.description
        }
    }
    
    // TODO: Use feature flagging or something for this instead!
    var enabled: Bool {
        switch self {
        case .snooze: return false
        default: return true
        }
    }
}

enum SettingsActionItem: String, CaseIterable {
    case showCompleted
    case clearList
    
    var title: String {
        switch self {
        case .showCompleted:
            return Localized.Settings.ShowComplete.title
        case .clearList:
            return Localized.Settings.Delete.title
        }
    }
    
    var description: String {
        switch self {
        case .showCompleted:
            return Localized.Settings.ShowComplete.description
        case .clearList:
            return Localized.Settings.Delete.description
        }
    }
    
    var enabled: Bool {
        true
    }
}
