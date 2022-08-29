//
//  AlertConfig.swift
//  
//
//  Created by Rachel Schneebaum on 8/29/22.
//

import SwiftUI

public enum AlertConfig {
    case error(LocalizedError)
    case clearList(() -> Void)
    
    var alert: Alert {
        switch self {
        case let .error(error):
            return .init(
                title: .init(Localized.error),
                message: .init(error.localizedDescription),
                dismissButton: .cancel(.init(Localized.ok))
            )
            
        case let .clearList(clearAction):
            return .init(
                title: .init(Localized.Alert.ClearList.title),
                message: .init(Localized.Alert.ClearList.message),
                primaryButton: .destructive(
                    .init(Localized.Alert.ClearList.actionTitle),
                    action: clearAction
                ),
                secondaryButton: .cancel()
            )
        }
    }
}
