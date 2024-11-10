//
//  Settings.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

struct Settings: View {
    @State private var viewModel: SettingsViewModel
    
    init(appState: AppState) {
        self.viewModel = SettingsViewModel(appState: appState)
    }
    
    var body: some View {
        Form {
            Section("Data") {
                Toggle(isOn: $viewModel.appState.useMockData) {
                    Text("Mock Data")
                }
            }
        }
    }
}

#Preview {
    Settings(appState: AppState())
}
