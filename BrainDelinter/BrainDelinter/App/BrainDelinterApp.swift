//
//  BrainDelinterApp.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/18/22.
//

import SwiftUI
import DelinterNavigation

@main
struct BrainDelinterApp: App {
    @StateObject private var navigationState: AppNavigationState = .init()
    
    var body: some Scene {
        WindowGroup {
            TabRouterView()
                .environmentObject(navigationState)
        }
    }
}


private struct TabRouterView: View {
    @EnvironmentObject var navigationState: AppNavigationState
    
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
                        // TODO: Replace with router
                        Color.cyan.opacity(0.7)
                        
                    case .settings:
                        SettingsRouterView()
                    }
                }
                .tabItem {
                    tab.icon
                    Text(tab.title)
                }
            }
        }
    }
}
