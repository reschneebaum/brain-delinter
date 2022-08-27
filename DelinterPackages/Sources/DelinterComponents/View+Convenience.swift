//
//  File.swift
//  
//
//  Created by Rachel Schneebaum on 8/27/22.
//

import SwiftUI

public extension View {
    func backgroundColorOnWhite(_ color: Color) -> some View {
        background(
            ZStack {
                Color.white
                color
            }
        )
    }
}
