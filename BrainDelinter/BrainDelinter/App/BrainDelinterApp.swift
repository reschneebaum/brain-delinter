//
//  BrainDelinterApp.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import CoreData
import SwiftUI
import DelinterComponents
import DelinterNotifications

@main
struct BrainDelinterApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var dataStore: LocalDataStore = .init()
    @StateObject private var navigationState: AppNavigationState = .init()
    private let notificationScheduler: NotificationScheduler = .init()
    private let userDefaults: UserDefaults = .standard
    
    var body: some Scene {
        WindowGroup {
            TabsContainerView()
                .environmentObject(navigationState)
                .environmentObject(dataStore)
                .environment(\.userDefaults, userDefaults)
                .environment(\.managedObjectContext, dataStore.managedObjectContext) // do i need this??
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .background, .inactive:
                // Make sure the core data db is updated with the environment moc whenever leaving the app
                dataStore.save()
                print("active tab: \(navigationState.selectedTab?.title)")
                
            case .active: break
            @unknown default: break
            }
        }
    }
    
    init() {
        if userDefaults.scheduledStartTime != nil {
            // we already have a scheduled time; check permission (+ schedule if needed)
            notificationScheduler.configureNotificationsSession()
        }
    }
}
