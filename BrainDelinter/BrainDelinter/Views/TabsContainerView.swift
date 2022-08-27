//
//  TabsContainerView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import SwiftUI

struct TabsContainerView: View {
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

struct TabRouterView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContainerView()
            .environmentObject(AppNavigationState())
    }
}
