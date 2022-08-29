//
//  AlertPresentingModifier.swift
//  
//
//  Created by Rachel Schneebaum on 8/29/22.
//

import SwiftUI

public extension View {
    func alertPresenting(_ alertManager: AlertManager) -> some View {
        modifier(AlertPresentingModifier(alertManager: alertManager))
    }
}

private struct AlertPresentingModifier: ViewModifier {
    @ObservedObject var alertManager: AlertManager

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $alertManager.isPresented) {
                alertManager.alert ?? .init(title: .init(Localized.error))
            }
    }
}
