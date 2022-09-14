//
//  File.swift
//  
//
//  Created by Rachel Schneebaum on 9/10/22.
//

import SwiftUI

public extension Font {
    /// System | size 40
    static let titleEmoji: Font = .system(size: 40)
    
    /// System font with `design: .rounded`
    enum Rounded {
        /// System font with `weight: .light`
        public enum Light {
            /// System | size 32
            public static let header: Font = .system(size: 32, weight: .light, design: .rounded)
            /// System | size 20
            public static let subheader: Font = .system(size: 20, weight: .light, design: .rounded)
            /// System | size 15
            public static let body: Font = .system(size: 15, weight: .light, design: .rounded)
            /// System | size 13
            public static let bodyS: Font = .system(size: 13, weight: .light, design: .rounded)
        }
        
        public enum Medium {
            /// System | size 15
            public static let body: Font = .system(size: 15, weight: .medium, design: .rounded)
        }
        
        /// System | size 13
        public static let bodyS: Font = .system(size: 13, design: .rounded).italic()
    }
    
    /// Font with `italic()` modifier applied
    enum Italic {
        /// System `.caption` style
        public static let footnote: Font = .caption.italic()
        /// System | size 15
        public static let body: Font = .Rounded.Light.body.italic()
    }
}
