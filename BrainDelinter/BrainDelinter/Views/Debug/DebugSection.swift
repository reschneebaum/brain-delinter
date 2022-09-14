//
//  DebugSection.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/10/22.
//

enum DebugSection: String, CaseIterable {
    case notifications
    case userDefaults
    case clearCaches
}

// MARK: - Extensions
 
// MARK: ListSection

extension DebugSection: ListSection {
    var title: String {
        switch self {
        case .notifications:
            return Localized.Debug.notifications
        case .userDefaults:
            return Localized.Debug.defaults
        case .clearCaches:
            return Localized.Debug.clearCache
        }
    }
    
    var rows: [DebugItem] {
        switch self {
        case .notifications:
            return DebugItem.notificationCenterItems
        case .userDefaults:
            return DebugItem.userDefaultsItems
        case .clearCaches:
            return DebugItem.deleteActionItems
        }
    }
}
