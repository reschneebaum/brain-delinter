//
//  File.swift
//  
//
//  Created by Rachel Schneebaum on 8/29/22.
//

import SwiftUI

public class AlertManager: ObservableObject {
    @Published var isPresented = false
    @Published var error: LocalizedError? {
        didSet {
            isPresented = error != nil
        }
    }

    @Published var alert: Alert? {
        didSet {
            isPresented = alert != nil
        }
    }
    
    public init() {}

    public func dismiss() {
        withAnimation {
            alert = nil
            error = nil
        }
    }
    
    public func showAlert(for config: AlertConfig) {
        showAlert(config.alert)
    }

    public func showErrorAlert(_ error: LocalizedError) {
        showAlert(for: .error(error))
    }

    func showAlert(_ alert: Alert) {
        self.alert = alert
    }
}
