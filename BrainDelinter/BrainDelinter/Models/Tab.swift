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
    
    var icon: String {
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
        rawValue
    }
}
