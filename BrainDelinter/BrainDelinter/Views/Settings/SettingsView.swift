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
    @Environment(\.userDefaults) var userDefaults
    
    @State private var selectedDate: Date = .now
    @State private var allowSnooze = false
    /// Default time interval is 20 minutes.
    @State private var duration = Constants.defaultTimeInterval
    
    private let durationRange = Constants.durationRange
    private let alarmSettings = SettingsItem.allCases
    
    var body: some View {
        List {
            Section {
                ForEach(alarmSettings, id: \.self) { setting in
                    SettingsRow(description: setting.description) {
                        Group {
                            switch setting {
                            case .alarmTime:
                                TimePicker(selectedTime: $selectedDate, label: setting.title)
                                    .onChange(of: selectedDate) { newValue in
                                        userDefaults.scheduledStartTime = newValue
                                    }
                            case .snooze:
                                CheckboxToggle(isOn: $allowSnooze, label: setting.title)
                                    .onChange(of: allowSnooze) { newValue in
                                        userDefaults.allowSnooze = newValue
                                    }
                            case .duration:
                                durationRowContent
                            }
                        }
                    }
                }
            } header: {
                Text(Localized.Settings.Alarm.sectionHeader)
            }
        }
        .navigationTitle(Localized.Settings.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            selectedDate = userDefaults.scheduledStartTime ?? .now
            duration = userDefaults.interval > 0 ? userDefaults.interval : Constants.defaultTimeInterval
            allowSnooze = userDefaults.allowSnooze
        }
    }
    
    private var durationRowContent: some View {
        HStack(spacing: 0) {
            Text(SettingsItem.duration.title)
                .font(.Rounded.Medium.body)
            
            Spacer()
            
            Picker(SettingsItem.duration.title, selection: $duration) {
                ForEach(durationRange, id: \.self) {
                    Text("\($0) min")
                        .font(.Rounded.Light.body)
                }
            }
            .pickerStyle(.menu)
            .labelStyle(.titleOnly)
        }
        .onChange(of: duration) { newValue in
            userDefaults.interval = newValue
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
        .environmentObject(AppNavigationState())
        .environment(\.userDefaults, .mocked)
    }
}
