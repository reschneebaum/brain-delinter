//
//  BrainDelinterConstants.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI

enum Padding: CGFloat {
    case xLarge = 24
    case large = 16
    case medium = 12
    case small = 8
    case xSmall = 4
}

extension Font {
    static let titleEmoji: Font = .system(size: 40)
    
    enum Rounded {
        enum Light {
        static let header: Font = .system(size: 32, weight: .light, design: .rounded)
        static let subheader: Font = .system(size: 20, weight: .light, design: .rounded)
        static let body: Font = .system(size: 15, weight: .light, design: .rounded)
        }
    }
    
    enum Italic {
        static let footnote: Font = .caption.italic()
    }
}
