//
//  ListRouterView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import SwiftUI
import DelinterNavigation

struct ListRouterView: View {
    @EnvironmentObject var navigationState: AppNavigationState
    
    var body: some View {
        NavigationStack($navigationState.listStackManager.stack) {
            switch $0 {
            case .home:
                ListView()
            }
        }
    }
}

enum ListRoute {
    case home
}

struct ListRouterView_Previews: PreviewProvider {
    static var previews: some View {
        ListRouterView()
    }
}
