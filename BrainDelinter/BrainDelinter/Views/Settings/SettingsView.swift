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

struct SettingsView<DataStore: DataStoreInterface>: View {
    // TODO: Use @AppStorage instead??
    @Environment(\.userDefaults) var userDefaults
    @EnvironmentObject var dataStore: DataStore
    
    @State private var selectedDate: Date = .now
    @State private var allowSnooze = false
    @State private var duration = Constants.defaultTimeInterval
    @State private var isAlertPresented = false
    
    private let durationRange = Constants.durationRange
    private let alarmSettings = SettingsItem.allCases
    private let listSettings = SettingsActionItem.allCases
    
    var body: some View {
        List {
            Section {
                alarmSettingsSectionContent
            } header: {
                Text(Localized.Settings.Alarm.sectionHeader)
            }
            
            Section {
                listSettingsSectionContent
            } header: {
                Text(Localized.Settings.List.sectionHeader)
            }
        }
        .navigationTitle(Localized.Settings.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var alarmSettingsSectionContent: some View {
        ForEach(alarmSettings, id: \.self) { setting in
            SettingsRow(description: setting.description) {
                Group {
                    switch setting {
                    case .alarmTime:
                        TimePicker(selectedTime: $selectedDate, label: setting.title, font: .Rounded.Medium.body)
                            .onChange(of: selectedDate) { newValue in
                                userDefaults.scheduledStartTime = newValue
                            }
                        
                    case .snooze:
                        CheckboxToggle(isOn: $allowSnooze, label: setting.title, font: .Rounded.Medium.body)
                            .onChange(of: allowSnooze) { newValue in
                                userDefaults.allowSnooze = newValue
                            }
                        
                    case .duration:
                        Picker(SettingsItem.duration.title, selection: $duration) {
                            ForEach(durationRange, id: \.self) {
                                Text("\($0) min").font(.Rounded.Light.body)
                            }
                        }
                        .pickerStyle(.menu)
                        .labelStyle(.titleOnly)
                        .onChange(of: duration) { newValue in
                            userDefaults.duration = newValue
                        }
                    }
                }
            }
        }
        .onAppear {
            selectedDate = userDefaults.scheduledStartTime ?? .now
            duration = userDefaults.duration > 0 ? userDefaults.duration : Constants.defaultTimeInterval
            allowSnooze = userDefaults.allowSnooze
        }
    }
    
    private var listSettingsSectionContent: some View {
        ForEach(listSettings, id: \.self) { setting in
            SettingsRow(description: setting.description) {
                Group {
                    switch setting {
                    case .clearList:
                        Text(setting.title)
                    }
                }
            }
            .simultaneousGesture(
                TapGesture().onEnded {
                    switch setting {
                    case .clearList:
                        isAlertPresented = true
                    }
                }
            )
        }
        .alert(
            .clearList(dataStore.clearAllItems),
            isPresented: $isAlertPresented
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView<MockDataStore>()
        }
        .environmentObject(MockDataStore())
        .environment(\.userDefaults, .mocked)
    }
}
