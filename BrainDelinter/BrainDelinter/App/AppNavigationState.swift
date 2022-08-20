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
    // Add other tabs' stack managers
}

struct NavigationStateKey: EnvironmentKey {
    static var defaultValue: AppNavigationState = .init()
}

extension EnvironmentValues {
    var navigationState: AppNavigationState {
        get {
            self[NavigationStateKey.self]
        }
        set {
            self[NavigationStateKey.self] = newValue
        }
    }
}
