//
//  EnvironmentValues+DelinterValues.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/28/22.
//

import DelinterLocalStorage
import Foundation
import SwiftUI

extension EnvironmentValues {
    /// The current environment's user defaults
    /// - Note: the value only changes in unit tests and previews — i.e., when we shouldn't use `.standard`
    var defaults: DefaultsCacheing {
        get {
            self[UserDefaultsKey.self]
        }
        set {
            self[UserDefaultsKey.self] = newValue
        }
    }
    
    var selectedTab: Binding<Tab> {
        get {
            self[SelectedTabKey.self]
        }
        set {
            self[SelectedTabKey.self] = newValue
        }
    }
    
    var isAppLoading: Binding<Bool> {
        get {
            self[LoadingStateKey.self]
        }
        set {
            self[LoadingStateKey.self] = newValue
        }
    }
}

private struct UserDefaultsKey: EnvironmentKey {
    static var defaultValue: DefaultsCacheing = LocalData.defaults
}

private struct SelectedTabKey: EnvironmentKey {
    static var defaultValue: Binding<Tab> = .constant(.list)
}

private struct LoadingStateKey: EnvironmentKey {
    static var defaultValue: Binding<Bool> = .constant(false)
}
