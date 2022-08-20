//
//  SettingsRow.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/20/22.
//

import SwiftUI

struct SettingsRow<Content: View>: View {
    var description: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            content()
            
            Text(description)
                .italic()
                .font(.caption)
//                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, 8)
        .padding(.top, 4)
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(description: "just a lil test row") {
            HStack {
                Text("hello world")
                Image(systemName: "bicycle")
            }
        }
    }
}
