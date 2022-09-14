//
//  StatsView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/26/22.
//

import DelinterComponents
import SwiftUI

// TODO: This is temporary!

struct StatsView: View {
    var body: some View {
        DebugView()
            .navigationTitle("debuggin 🐛🐞")
            .navigationBarTitleDisplayMode(.inline)
        
        /*
        ZStack {
            Color.teal.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: Padding.mediumSmall.rawValue) {
                Text(Localized.Stats.wipExplainerHeader)
                    .font(.Rounded.Light.header)
                
                Spacer()
                
                Text("🧼 🧠")
                    .font(.titleEmoji)
                
                Text(Localized.Stats.wipExplainerBody)
                    .font(.Rounded.Light.subheader)
                
                Spacer()
            }
            .padding(.top, Padding.large.rawValue)
        }
        .navigationTitle(Localized.Stats.title)
        .navigationBarTitleDisplayMode(.inline)
         */
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StatsView()
        }
    }
}
