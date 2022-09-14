//
//  NotificationScheduler.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import Combine
import DelinterLocalStorage
import UserNotifications

public class NotificationScheduler: NSObject, ObservableObject {
    public private(set) var permissionGranted: Bool?
    private let notificationCenter: UNUserNotificationCenter
    private let userDefaults: UserDefaults
    private var disposables: Set<AnyCancellable> = []
    
    // MARK: Init
    
    public init(notificationCenter: UNUserNotificationCenter = .current(), userDefaults: UserDefaults = .standard) {
        self.notificationCenter = notificationCenter
        self.userDefaults = userDefaults
        super.init()
        
        let startPublisher = userDefaults.publisher(for: \.scheduledStartTime)
            .removeDuplicates()
//            .dropFirst()
            .eraseToAnyPublisher()
        let durationPublisher = userDefaults.publisher(for: \.duration)
            .removeDuplicates()
//            .dropFirst()
            .eraseToAnyPublisher()
        
        Publishers.CombineLatest(startPublisher, durationPublisher).sink { [weak self] _ in
            self?.updateNotificationTimes()
        }
        .store(in: &disposables)
    }
    
    // MARK: Public Methods
    
    /// Synchronous version; also see asynchronous version of the same name
    public func configureNotificationsSession() {
        Task.detached(priority: .background) {
            guard await self.requestPermission() else { return }
            await self.scheduleNotifications()
        }
    }
    
    /// Asynchronous version; also see synchronous version of the same name
    public func configureNotificationsSession() async {
        guard await requestPermission() else { return }
        await scheduleNotifications()
    }
    
    public func updateNotificationTimes() {
        clearCurrentScheduledNotifications()
        
        Task.detached(priority: .background) {
            await self.scheduleNotifications()
        }
    }
    
    public func clearCurrentScheduledNotifications() {
        notificationCenter.removePendingNotificationRequests(
            withIdentifiers: NotificationConfig.allCases.map(\.rawValue)
        )
//        notificationCenter.removeAllPendingNotificationRequests()
    }
}

// MARK: Private Extension

private extension NotificationScheduler {
    func authorizationPermissionGranted() async -> Bool? {
        let status = await notificationCenter.notificationSettings().authorizationStatus
        switch status {
        case .notDetermined:
            return nil
        case .denied:
            permissionGranted = false
            return false
        case .authorized, .provisional, .ephemeral:
            permissionGranted = true
            return true
        @unknown default:
            return false
        }
    }
    
    func requestPermission() async -> Bool {
        if let permissionStatus = await authorizationPermissionGranted() {
            // Permission has already been granted (or denied), no need to request again.
            return permissionStatus
        }
        if let requestAuthorized = try? await notificationCenter.requestAuthorization(
            options: [.sound, .alert, .badge, .carPlay]
        ) {
            permissionGranted = requestAuthorized
            return requestAuthorized
        }
        return false
    }
    
    func scheduleNotifications() async {
        let currentRequests = await notificationCenter.pendingNotificationRequests()
        
        // Notifications are already scheduled; we don't need to schedule them again.
        if !currentRequests.isEmpty,
            Set(NotificationConfig.allCases.map(\.rawValue)).isSubset(of: Set(currentRequests.map(\.identifier))) {
            return
        }
        
        // Can't schedule a notification with no start/end times
        guard let startTime = userDefaults.startTimeComponents,
              let endTime = userDefaults.endTimeComponents else {
            return
        }
        
        do {
            try await notificationCenter.add(.dailyStartTime(at: startTime))
            try await notificationCenter.add(.dailyEndTime(at: endTime))
        } catch {
            // TODO: Better error handling
            print("error scheduling notifications: \(error.localizedDescription)")
        }
    }
}

// MARK: UNUserNotificationCenterDelegate

extension NotificationScheduler: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // TODO: handle deeplinking when(/if?) necessary
            print("notification tapped")

        default: break
        }
    }
}
