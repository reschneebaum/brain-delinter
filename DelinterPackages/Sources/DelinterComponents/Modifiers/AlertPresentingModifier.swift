//
//  AlertPresentingModifier.swift
//  
//
//  Created by Rachel Schneebaum on 8/29/22.
//

import SwiftUI

public extension View {
    func alert(_ config: AlertConfig, isPresented: Binding<Bool>) -> some View {
        modifier(AlertPresentingModifier(config: config, isPresented: isPresented))
    }
}

private struct AlertPresentingModifier: ViewModifier {
    let config: AlertConfig
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content.alert(config.title, isPresented: $isPresented) {
            config.actionButtons
        } message: {
            Text(config.message)
        }
    }
}
