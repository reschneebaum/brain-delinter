//
//  SettingsItem.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/26/22.
//

enum AlarmSetting: String, RowRepresenting, CaseIterable {
    case startTime
    case duration
    case snooze
    
    var title: String {
        switch self {
        case .startTime:
            return Localized.Settings.Alarm.title
        case .duration:
            return Localized.Settings.Duration.title
        case .snooze:
            return Localized.Settings.Snooze.title
        }
    }
    
    var description: String {
        switch self {
        case .startTime:
            return Localized.Settings.Alarm.description
        case .duration:
            return Localized.Settings.Duration.description
        case .snooze:
            return Localized.Settings.Snooze.description
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

enum ListSetting: String, RowRepresenting, CaseIterable {
    case showComplete
    case clearAll
    
    var title: String {
        switch self {
        case .showComplete:
            return Localized.Settings.ShowComplete.title
        case .clearAll:
            return Localized.Settings.ClearAll.title
        }
    }
    
    var description: String {
        switch self {
        case .showComplete:
            return Localized.Settings.ShowComplete.body
        case .clearAll:
            return Localized.Settings.ClearAll.body
        }
    }
}
