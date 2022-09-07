//
//  ListRouterView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import SwiftUI
import DelinterLocalStorage
import DelinterNavigation

struct ListRouterView: View {
    @ObservedObject var stackManager: NavigationStackManager<ListRoute>
    
    var body: some View {
        NavigationStack($stackManager.stack) {
            switch $0 {
            case .home:
                ListView<LocalDataStore>()
            }
        }
    }
}

enum ListRoute {
    case home
}

struct ListRouterView_Previews: PreviewProvider {
    static var previews: some View {
        ListRouterView(stackManager: .init(withRoot: .home))
    }
}
