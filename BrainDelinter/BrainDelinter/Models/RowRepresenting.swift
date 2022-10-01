//
//  RowRepresenting.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 10/1/22.
//

protocol RowRepresenting {
    var title: String { get }
    var description: String { get }
    var enabled: Bool { get }
}

extension RowRepresenting {
    var enabled: Bool {
        true
    }
}
