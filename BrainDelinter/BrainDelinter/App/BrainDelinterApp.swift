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
    @StateObject private var navigationState: AppNavigationState = .init()
    private var dataStore: LocalDataStore = .init()
    private let notificationScheduler: NotificationScheduler = .init()
    private let userDefaults: UserDefaults = .standard
    
    @State private var isLoading = false
    
    var body: some Scene {
        WindowGroup {
            TabsContainerView(navigationState: navigationState)
                .isLoading($isLoading)
                .environmentObject(dataStore)
                .environment(\.userDefaults, userDefaults)
                .environment(\.isAppLoading, $isLoading)
                .environment(\.managedObjectContext, dataStore.managedObjectContext) // do i need this??
                .onAppear {
                    if navigationState.selectedTab == nil {
                        navigationState.selectedTab = .list
                    }
                }
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .background, .inactive:
                // Make sure the core data db is updated with the environment moc whenever leaving the app
                dataStore.save()
                
            case .active: break
            @unknown default: break
            }
        }
        .onChange(of: isLoading) { newValue in
            if navigationState.isLoading != newValue {
                navigationState.isLoading = newValue
            }
        }
        .onChange(of: navigationState.isLoading) { newValue in
            if isLoading != newValue {
                isLoading = newValue
            }
        }
    }
    
    init() {
        if userDefaults.isStartTimeSet {
            // we already have a scheduled time; check permission (+ schedule if needed)
            notificationScheduler.configureNotificationsSession()
        }
    }
}
