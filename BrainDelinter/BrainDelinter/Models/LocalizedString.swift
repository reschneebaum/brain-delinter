//
//  LocalizedString.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import Foundation

extension String {
    var localized: String {
        localized(with: "")
    }
    
    func localized(with comment: String) -> String {
        NSLocalizedString(self, comment: comment)
    }
}
