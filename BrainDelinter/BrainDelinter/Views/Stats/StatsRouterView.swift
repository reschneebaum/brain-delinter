//
//  StatsRouterView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/26/22.
//

import SwiftUI
import DelinterNavigation

struct StatsRouterView: View {
    @EnvironmentObject var navigationState: AppNavigationState
    
    var body: some View {
        NavigationStack($navigationState.listStackManager.stack) {
            switch $0 {
            case .home:
                StatsView()
            }
        }
    }
}

enum StatsRoute {
    case home
}

struct StatsRouterView_Previews: PreviewProvider {
    static var previews: some View {
        StatsRouterView()
    }
}
