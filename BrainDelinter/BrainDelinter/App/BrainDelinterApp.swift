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
            NavigationView {
                TabRouterView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(navigationState)
        }
    }
}



private struct TabRouterView: View {
    @Environment(\.navigationState) var navigationState
    
    private var selectedBinding: Binding<Tab?> {
        .init {
            navigationState.selectedTab
        } set: {
            navigationState.selectedTab = $0
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
                        // TODO: Replace with router
                        SetAlarmTimeView()
                    }
                }
                .tabItem {
                    Image(systemName: tab.icon)
                    Text(tab.title)
                }
            }
        }
    }
}
