//
//  SettingsRouterView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import SwiftUI
import DelinterLocalStorage
import DelinterNavigation

struct SettingsRouterView: View {
    @ObservedObject var stackManager: NavigationStackManager<SettingsRoute>
    
    var body: some View {
        NavigationStack($stackManager.stack) {
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
        SettingsRouterView(stackManager: .init(withRoot: .home))
    }
}
