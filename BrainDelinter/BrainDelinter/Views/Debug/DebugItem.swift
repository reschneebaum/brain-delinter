//
//  DebugItem.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/10/22.
//

enum DebugItem: String, CaseIterable {
    case notificationPermission
    case pendingNotifications
    case persistedStartTime
    case persistedEndTime
    case persistedDuration
    case clearUserDefaults
    case clearCoreData
    case clearNotifications
    
    static let notificationCenterItems: [Self] = [
        .notificationPermission,
        .pendingNotifications
    ]
    static let userDefaultsItems: [Self] = [
        .persistedStartTime,
        .persistedEndTime,
        .persistedDuration
    ]
    static let deleteActionItems: [Self] = [
        .clearUserDefaults,
        .clearCoreData,
        .clearNotifications
    ]
}

// MARK: - Extensions

// MARK: ListRow

extension DebugItem: ListRow {
    var title: String {
        switch self {
        case .notificationPermission:
            return Localized.Debug.Notifications.permission
        case .pendingNotifications:
            return Localized.Debug.Notifications.pending
        case .persistedStartTime:
            return Localized.Debug.Defaults.startTime
        case .persistedEndTime:
            return Localized.Debug.Defaults.endTime
        case .persistedDuration:
            return Localized.Debug.Defaults.duration
        case .clearUserDefaults:
            return Localized.Debug.Clear.defaults
        case .clearCoreData:
            return Localized.Debug.Clear.coreData
        case .clearNotifications:
            return Localized.Debug.Clear.notifications
        }
    }
    
    var hasValue: Bool {
        switch self {
        case .clearNotifications, .clearUserDefaults, .clearCoreData:
            return false
        default:
            return true
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .clearUserDefaults, .clearCoreData, .clearNotifications:
            return true
        default:
            return false
        }
    }
    
    var isButton: Bool {
        switch self {
        case .clearUserDefaults, .clearCoreData, .clearNotifications:
            return true
        default:
            return false
        }
    }
}
