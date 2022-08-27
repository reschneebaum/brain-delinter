//
//  StatsView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/26/22.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        ZStack {
            Color.teal.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: Padding.medium.rawValue) {
                Text(Localized.Stats.wipExplainerHeader)
                    .font(.Rounded.Light.header)
                
                Spacer()
                
                Text("🧼 🧠")
                    .font(.titleEmoji)
                
                Text(Localized.Stats.wipExplainerBody)
                    .font(.Rounded.Light.subheader)
                
                Spacer()
            }
            .padding(.top, Padding.xLarge.rawValue)
        }
        .navigationTitle(Localized.Stats.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StatsView()
        }
    }
}
