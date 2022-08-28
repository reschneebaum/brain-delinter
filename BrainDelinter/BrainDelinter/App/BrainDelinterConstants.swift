//
//  BrainDelinterConstants.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import SwiftUI

enum Padding: CGFloat {
    /// 24 pt
    case xLarge = 24
    /// 16 pt
    case large = 16
    /// 12 pt
    case medium = 12
    /// 8 pt
    case small = 8
    /// 4 pt
    case xSmall = 4
}

extension Font {
    /// System | size 40
    static let titleEmoji: Font = .system(size: 40)
    
    /// System font with `design: .rounded`
    enum Rounded {
        /// System font with `weight: .light`
        enum Light {
            /// System | size 32
            static let header: Font = .system(size: 32, weight: .light, design: .rounded)
            /// System | size 20
            static let subheader: Font = .system(size: 20, weight: .light, design: .rounded)
            /// System | size 15
            static let body: Font = .system(size: 15, weight: .light, design: .rounded)
            /// System | size 13
            static let bodyS: Font = .system(size: 13, weight: .light, design: .rounded)
        }
        
        /// System | size 13
        static let bodyS: Font = .system(size: 13, design: .rounded).italic()
    }
    
    /// Font with `italic()` modifier applied
    enum Italic {
        /// System `.caption` style
        static let footnote: Font = .caption.italic()
        /// System | size 15
        static let body: Font = .Rounded.Light.body.italic()
    }
}
