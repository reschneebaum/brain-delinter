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
    
    // MARK: Init
    
    init(notificationCenter: UNUserNotificationCenter = .current(), userDefaults: UserDefaults = .standard) {
        self.notificationCenter = notificationCenter
        self.userDefaults = userDefaults
    }
    
    // MARK: Internal Methods
    
    /// Synchronous version; also see asynchronous version of the same name
    func configureNotificationsSession() {
        Task.detached(priority: .background) {
            guard await self.requestPermission() else { return }
            await self.scheduleNotifications()
        }
    }
    
    /// Asynchronous version; also see synchronous version of the same name
    func configureNotificationsSession() async {
        guard await requestPermission() else { return }
        await scheduleNotifications()
    }
}

// MARK: Private Extension

private extension NotificationScheduler {
    func requestPermission() async -> Bool {
        let status = await notificationCenter.notificationSettings().authorizationStatus
        switch status {
        case .notDetermined:
            return (try? await notificationCenter.requestAuthorization()) ?? false
        case .denied:
            return false
        case .authorized, .provisional, .ephemeral:
            return true
        @unknown default:
            return false
        }
    }
    
    func scheduleNotifications() async {
        let currentRequests = await notificationCenter.pendingNotificationRequests()
        // Notifications are already scheduled; we don't need to schedule them again.
        guard currentRequests.isEmpty else { return }
        
        // Can't schedule a notification with no start/end times
        guard let startTime = userDefaults.startTimeComponents,
              let endTime = userDefaults.endTimeComponents else { return }
        
        do {
            try await notificationCenter.add(.dailyStartTime(at: startTime))
            try await notificationCenter.add(.dailyEndTime(at: endTime))
        } catch {
            print("error scheduling notifications: \(error.localizedDescription)")
        }
    }
    
    func clearCurrentScheduledNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}

// MARK: UNUserNotificationCenterDelegate

extension NotificationScheduler: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // TODO: handle deeplinking when(/if?) necessary
                break
        default: break
        }
    }
}
