//
//  BrainDelinterApp.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import CoreData
import DelinterNavigation
import SwiftUI

@main
struct BrainDelinterApp: App {
    @StateObject private var dataStore: LocalDataStore = .init()
    @StateObject private var navigationState: AppNavigationState = .init()
    
    var body: some Scene {
        WindowGroup {
            TabRouterView()
                .environmentObject(navigationState)
                .environment(\.managedObjectContext, dataStore.container.viewContext)
        }
    }
}

private struct TabRouterView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var navigationState: AppNavigationState
    @FetchRequest(sortDescriptors: []) var items: FetchedResults<ManagedListItem>
    
    private var selectedBinding: Binding<Tab?> {
        .init {
            navigationState.selectedTab
        } set: {
            guard let newValue = $0 else { return }
            navigationState.selectedTab = newValue
        }
    }
    
    var body: some View {
        TabView(selection: selectedBinding) {
            ForEach(navigationState.tabs, id: \.self) { tab in
                Group {
                    switch tab {
                    case .list:
                        ListRouterView()
                        
                    case .stats:
                        StatsRouterView()
                        
                    case .settings:
                        SettingsRouterView()
                    }
                }
                .tabItem {
                    VStack(spacing: 2) {
                        Image(systemName: tab.iconName)
                        Text(tab.title)
                    }
                    .foregroundColor(.accentColor)
                }
            }
        }
    }
}
