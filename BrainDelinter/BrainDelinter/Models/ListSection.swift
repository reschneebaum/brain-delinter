//
//  ListSection.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 9/10/22.
//

import Foundation

protocol ListSection: Identifiable {
    associatedtype Row: ListRow
    var title: String { get }
    var rows: [Row] { get }
    var rawValue: String { get }
}

extension ListSection {
    var id: String {
        rawValue
    }
}

protocol ListRow: Identifiable {
    var rawValue: String { get }
    var id: String { get }
    var title: String { get }
    var description: String? { get }
    var hasValue: Bool { get }
    var isEnabled: Bool { get }
    var isButton: Bool { get }
//    var action: (() -> Void)? { get }
}

extension ListRow {
    var description: String? {
        nil
    }
    var hasValue: Bool {
        false
    }
    var isEnabled: Bool {
        false
    }
    var isButton: Bool {
        false
    }
    var action: (() -> Void)? {
        nil
    }
    var id: String {
        rawValue
    }
}
