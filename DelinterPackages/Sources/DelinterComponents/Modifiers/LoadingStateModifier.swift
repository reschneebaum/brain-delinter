//
//  LoadingStateModifier.swift
//  
//
//  Created by Rachel Schneebaum on 9/3/22.
//

import SwiftUI

public extension View {
    func isLoading(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadingStateModifier(isLoading: isLoading))
    }
}

struct LoadingStateModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoading {
                Color.white.opacity(0.3).overlay {
                    ProgressView()
                }
                .transition(.opacity)
                .animation(.easeInOut, value: true)
            }
        }
    }
}
