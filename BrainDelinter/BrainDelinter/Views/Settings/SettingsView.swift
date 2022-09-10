//
//  SettingsView.swift
//  BrainDelinter
//
//  Created by Rachel Schneebaum on 8/19/22.
//

import DelinterComponents
import DelinterLocalStorage
import SwiftUI

/*
 Future settings could include things like:
   1. automatically clear completed tasks
   2. do/don't rollover uncompleted tasks
   3. customize notification sound!?
 */

struct SettingsView<DataStore: LocalDataStoring>: View {
    // TODO: Use @AppStorage instead??
    @Environment(\.userDefaults) var userDefaults
    @Environment(\.selectedTab) var selectedTab
    @Environment(\.isAppLoading) var isAppLoading
    @EnvironmentObject var dataStore: DataStore
    
    @State private var selectedDate: Date = .now
    @State private var allowSnooze = false
    @State private var duration = Constants.defaultTimeInterval
    @State private var showCompleted = true
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
                        CheckboxToggle(
                            isOn: $allowSnooze,
                            label: setting.title,
                            font: .Rounded.Medium.body,
                            enabled: setting.enabled
                        )
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
            .disabledAppearance(!setting.enabled)
        }
        .onAppear {
            selectedDate = userDefaults.scheduledStartTime ?? .now
            duration = userDefaults.duration > 0 ? userDefaults.duration : Constants.defaultTimeInterval
            allowSnooze = userDefaults.allowSnooze
            showCompleted = userDefaults.showCompleted
        }
    }
    
    private var listSettingsSectionContent: some View {
        ForEach(listSettings, id: \.self) { setting in
            SettingsRow(description: setting.description) {
                Group {
                    switch setting {
                    case .showCompleted:
                        CheckboxToggle(isOn: $showCompleted, label: setting.title, font: .Rounded.Medium.body)
                            .onChange(of: showCompleted) { newValue in
                                userDefaults.showCompleted = newValue
                            }
                        
                    case .clearList:
                        HStack {
                            Text(setting.title)
                                .padding(.bottom, Padding.xSmall.rawValue)
                            
                            Spacer()
                            
                            Image(systemName: "trash")
                                .font(.system(size: 20))
                                .foregroundColor(.red)
                                .padding(.bottom, -12)
                        }
                        .contentShape(Rectangle())
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                isAlertPresented = true
                            }
                        )
                    }
                }
            }
            .disabledAppearance(!setting.enabled)
        }
        .alert(.clearList(onClearListSelected), isPresented: $isAlertPresented)
    }
}

// MARK: Private Methods

private extension SettingsView {
    func onClearListSelected() {
        isAppLoading.wrappedValue = true
        dataStore.clearAllItems()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            selectedTab.wrappedValue = .list
            isAppLoading.wrappedValue = false
        }
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
