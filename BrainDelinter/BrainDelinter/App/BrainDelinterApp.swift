//
//  BrainDelinterApp.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import CoreData
import SwiftUI

@main
struct BrainDelinterApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var dataStore: LocalDataStore = .init()
    @StateObject private var navigationState: AppNavigationState = .init()
    
    var body: some Scene {
        WindowGroup {
            TabsContainerView()
                .environmentObject(navigationState)
                .environmentObject(dataStore)
                .environment(\.managedObjectContext, dataStore.container.viewContext)
        }
        .onChange(of: scenePhase) { newValue in
            switch newValue {
            case .background, .inactive:
                // Update the core data model
                break
            case .active:
                break
            @unknown default:
                break
            }
        }
    }
}
