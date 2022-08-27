//
//  Tab.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

enum Tab: String, CaseIterable {
    case list
    case stats
    case settings
    
    var iconName: String {
        switch self {
        case .list:
            return "list.star"
        case .stats:
            return "chart.bar"
        case .settings:
            return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .list:
            return Localized.Tab.list
        case .stats:
            return Localized.Tab.stats
        case .settings:
            return Localized.Tab.settings
        }
    }
}
