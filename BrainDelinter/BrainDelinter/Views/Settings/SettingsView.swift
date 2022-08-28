//
//  SettingsView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import DelinterComponents
import SwiftUI

/*
 Future settings could include things like:
   1. automatically clear completed tasks
   2. do/don't rollover uncompleted tasks
   3. customize notification sound!?
 */

struct SettingsView: View {
    @State private var selected: Date = .now
    @State private var allowSnooze = false
    /// Default time interval is 20 minutes.
    @State private var duration = 20
    
    private let durationRange = 10...60
    private let alarmSettings = SettingsItem.allCases
    
    var body: some View {
        List {
            Section {
                ForEach(alarmSettings, id: \.self) { setting in
                    switch setting {
                    case .alarmTime:
                        SettingsRow(description: setting.description) {
                            TimePicker(selectedTime: $selected, label: setting.title)
                        }
                    case .snooze:
                        SettingsRow(description: setting.description) {
                            CheckboxToggle(isOn: $allowSnooze, label: setting.title)
                        }
                    case .duration:
                        SettingsRow(description: setting.description) {
                            durationRowContent
                        }
                    }
                }
            } header: {
                Text(Localized.Settings.Alarm.sectionHeader)
            }
        }
        .navigationTitle(Localized.Settings.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var durationRowContent: some View {
        HStack(spacing: 0) {
            Text(SettingsItem.duration.title)
            Spacer()
            
            Picker(SettingsItem.duration.title, selection: $duration) {
                ForEach(durationRange, id: \.self) {
                    Text("\($0) min")
                }
            }
            .pickerStyle(.menu)
            .labelStyle(.titleOnly)
        }
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
        .environmentObject(AppNavigationState())
    }
}
