//
//  SetAlarmTimeView.swift
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
 */

struct SetAlarmTimeView: View {
    @State private var selected: Date = .now
    @State private var allowSnooze = false
    /// Default time interval is 20 minutes.
    @State private var duration = 20
    
    private let durationRange = 0...100
    let alarmSettings = SettingsItem.allCases
    
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
                Text("alarm settings")
            }
        }
    }
    
    private var durationRowContent: some View {
        HStack(spacing: 0) {
            Text("how long")
            Spacer()
            
            Picker("productive duration", selection: $duration) {
                ForEach(durationRange, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.menu)
            .labelStyle(.titleOnly)
            
            Text("min")
        }
    }
}

enum SettingsItem: String, CaseIterable {
    case alarmTime
    case snooze
    case duration
    
    var title: String {
        switch self {
        case .alarmTime:
            return "daily alarm"
        case .snooze:
            return "allow snooze?"
        case .duration:
            return "how long?"
        }
    }
    var description: String {
        switch self {
        case .alarmTime:
            return "pick a time to start Getting Things Done!"
        case .snooze:
            return "if checked, we'll notify you again in 5 minutes"
        case .duration:
            return "we strongly recommend a 'do things' time of 20 minutes; much longer (or shorter) won't have the desired effect."
        }
    }
}

struct SetAlarmTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SetAlarmTimeView()
    }
}
