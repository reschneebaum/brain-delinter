//
//  TabsContainerView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import SwiftUI

struct TabsContainerView: View {
    @SceneStorage("selectedTab") private var selectedTab: Tab = .list
    @ObservedObject var navigationState: AppNavigationState
    private let tabs = Tab.allCases
    
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
        .environment(\.selectedTab, $selectedTab)
        .onChange(of: selectedTab) { newValue in
            if navigationState.selectedTab != newValue {
                navigationState.selectedTab = newValue
            }
        }
        .onChange(of: navigationState.selectedTab) { newValue in
            if let newValue, selectedTab != newValue {
                selectedTab = newValue
            }
        }
        .onAppear {
            selectedTab = navigationState.selectedTab ?? selectedTab
        }
        .onDisappear {
            selectedTab = .list
        }
    }
}

struct TabRouterView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContainerView(navigationState: .init())
    }
}
