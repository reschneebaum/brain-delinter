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
        VStack(alignment: .leading, spacing: Padding.xSmall.rawValue) {
            content()
                .font(.Rounded.Medium.body)
            
            Text(description)
                .font(.Italic.footnote)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.bottom, Padding.small.rawValue)
        .padding(.top, Padding.xSmall.rawValue)
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
