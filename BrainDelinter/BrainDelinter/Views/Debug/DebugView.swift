//
//  DebugView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/10/22.
//

import DelinterComponents
import DelinterLocalStorage
import DelinterNotifications
import SwiftUI

struct DebugView: View {
    @Environment(\.userDefaults) private var defaults
    @EnvironmentObject private var dataStore: LocalDataStore
    @EnvironmentObject private var notificationScheduler: NotificationScheduler
    
    @State private var id = UUID().uuidString
    
    var body: some View {
        List {
            ForEach(DebugSection.allCases, id: \.self) { section in
                Section(section.title) {
                    ForEach(section.rows, id: \.self) { item in
                        Group {
                            if item.isButton {
                                Button {
                                    performAction(for: item)
                                } label: {
                                    row(for: item)
                                }
                            } else {
                                row(for: item)
                                    .onTapGesture {
                                        performAction(for: item)
                                    }
                            }
                        }
                        .disabled(!item.isEnabled)
                    }
                }
            }
        }
        .id(id)
    }
    
    private func row(for item: DebugItem) -> some View {
        StyledListRow(title: item.title, description: item.description, value: value(for: item))
    }
    
    private func value(for item: DebugItem) -> String? {
        switch item {
        case .notificationPermission:
            if let permission = notificationScheduler.permissionGranted {
                return "\(permission)"
            } else {
                return "nil"
            }
        case .pendingNotifications:
            return "WIP"
        case .persistedStartTime:
            return defaults.scheduledStartTime?.ISO8601Format()
        case .persistedEndTime:
            return defaults.endTimeComponents?.date?.ISO8601Format()
        case .persistedDuration:
            return "\(defaults.duration)"
        default:
            return nil
        }
    }
    
    private func performAction(for item: DebugItem) {
        switch item {
        case .clearNotifications:
            notificationScheduler.clearCurrentScheduledNotifications()
        case .clearUserDefaults:
            defaults.scheduledStartTime = nil
            defaults.duration = 0
        case .clearCoreData:
            dataStore.clearAllItems()
        default:
            return
        }
        
        id = UUID().uuidString
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DebugView()
                .environmentObject(MockDataStore())
                .environmentObject(NotificationScheduler(notificationCenter: .current(), userDefaults: .mocked))
        }
    }
}
