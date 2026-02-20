//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Miguel Rodriguez on 2/20/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationStack {
            Form {
                ColorPicker("List BackgroundColor", selection: $listBackgroundColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                ColorPicker("Text Color", selection: $listTextColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
                    .padding()
                    .listRowBackground(listBackgroundColor)
            }
            .foregroundStyle(listTextColor)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
