//
//  AppNavigationState.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import SwiftUI
import DelinterNavigation

class AppNavigationState: ObservableObject {
    let tabs = Tab.allCases
    @Published var selectedTab: Tab?
    @Published var listStackManager: NavigationStackManager<ListRoute> = .init(withRoot: .home)
    @Published var statsStackManager: NavigationStackManager<StatsRoute> = .init(withRoot: .home)
    @Published var settingsStackManager: NavigationStackManager<SettingsRoute> = .init(withRoot: .home)
}
