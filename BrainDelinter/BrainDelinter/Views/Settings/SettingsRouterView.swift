//
//  SettingsRouterView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import SwiftUI
import DelinterNavigation

struct SettingsRouterView: View {
    @EnvironmentObject var navigationState: AppNavigationState
    
    var body: some View {
        NavigationStack($navigationState.settingsStackManager.stack) {
            switch $0 {
            case .home:
                SettingsView<LocalDataStore>()
            }
        }
    }
}

enum SettingsRoute {
    case home
}

struct SettingsRouterView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRouterView()
            .environmentObject(AppNavigationState())
    }
}
