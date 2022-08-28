//
//  NotificationScheduler.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Foundation
import UserNotifications

class NotificationScheduler: NSObject, ObservableObject {
    private let notificationCenter: UNUserNotificationCenter
    private let userDefaults: UserDefaults
    private let navigationState: AppNavigationState
    
    init(
        notificationCenter: UNUserNotificationCenter = .current(),
        userDefaults: UserDefaults = .standard,
        navigationState: AppNavigationState
    ) {
        self.notificationCenter = notificationCenter
        self.userDefaults = userDefaults
        self.navigationState = navigationState
    }
    
    func requestPermission() async throws {
        try await notificationCenter.requestAuthorization()
    }
    
    func scheduleNotifications() throws {
        guard let startTime = userDefaults.startTimeComponents,
              let endTime = userDefaults.endTimeComponents else {
            throw NotificationsError.missingScheduleTime
        }
        notificationCenter.add(.dailyStartTime(at: startTime))
        notificationCenter.add(.dailyEndTime(at: endTime))
    }
}

// MARK: UNUserNotificationCenterDelegate

extension NotificationScheduler: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            navigationState.selectedTab = .list
            
        default: break
        }
    }
}
