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
 */

struct SettingsView: View {
    @State private var selected: Date = .now
    @State private var allowSnooze = false
    /// Default time interval is 20 minutes.
    @State private var duration = 20
    
    private let durationRange = 0...60
    private let alarmSettings = SettingsItem.allCases
    
    // TODO: is this outermost VStack still needed?
    var body: some View {
        VStack {
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
                    Text("Settings.Alarm.sectionHeader")
                }
            }
        }
        .navigationTitle("Settings")
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

enum SettingsItem: String, CaseIterable {
    case alarmTime
    case snooze
    case duration
    
    var title: String {
        switch self {
        case .alarmTime:
            return "Settings.Alarm.title".localized
        case .snooze:
            return "Settings.Snooze.title".localized
        case .duration:
            return "Settings.Duration.title".localized
        }
    }
    var description: String {
        switch self {
        case .alarmTime:
            return "Settings.Alarm.description".localized
        case .snooze:
            return "Settings.Snooze.description".localized
        case .duration:
            return "Settings.Duration.description".localized
        }
    }
}

struct SetAlarmTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
