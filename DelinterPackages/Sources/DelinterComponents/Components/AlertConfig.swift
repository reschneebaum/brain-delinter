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
    
    public var title: String {
        switch self {
        case .error:
            return Localized.error
        case .clearList:
            return Localized.Alert.ClearList.title
        }
    }
    
    public var message: String {
        switch self {
        case let .error(error):
            return error.localizedDescription
        case .clearList:
            return Localized.Alert.ClearList.message
        }
    }
    
    @ViewBuilder
    public var actionButtons: some View {
        switch self {
        case .error:
            EmptyView()
        case let .clearList(clearAction):
            Button(Localized.cancel, role: .cancel) {}
            Button(Localized.Alert.ClearList.actionTitle, role: .destructive, action: clearAction)
        }
    }
}
