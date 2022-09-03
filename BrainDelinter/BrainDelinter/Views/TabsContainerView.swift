//
//  TabsContainerView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import SwiftUI

struct TabsContainerView: View {
    @StateObject var navigationState: AppNavigationState = .init()
    @SceneStorage("selectedTab") var selectedTab: Tab = .list
    let tabs = Tab.allCases
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs, id: \.self) { tab in
                Group {
                    switch tab {
                    case .list:
                        ListRouterView(stackManager: navigationState.listStackManager)
                        
                    case .stats:
                        StatsRouterView(stackManager: navigationState.statsStackManager)
                        
                    case .settings:
                        SettingsRouterView(stackManager: navigationState.settingsStackManager)
                    }
                }
                .tabItem {
                    Image(systemName: tab.iconName)
                    Text(tab.title)
                }
                .tag(tab)
            }
        }
        .environment(\.selectedTab, selectedTab)
        .environmentObject(navigationState)
    }
}

struct TabRouterView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContainerView()
    }
}
