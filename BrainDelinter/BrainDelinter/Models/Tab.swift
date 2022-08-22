//
//  Tab.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case list
    case stats
    case settings
    
    var icon: Image {
        var iconString = ""
        switch self {
        case .list:
            iconString = "list.star"
        case .stats:
            iconString = "chart.bar"
        case .settings:
            iconString = "gearshape"
        }
        return .init(systemName: iconString)
    }
    
    var title: String {
        rawValue
    }
}
