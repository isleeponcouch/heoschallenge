//
//  SettingsViewModel.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import Foundation

extension Settings {
    
    @Observable
    class SettingsViewModel: BaseViewModel {
        var devices: [Device] = []
        
        public func loadData() async {
            defer { isLoading = false }
            
            devices = try! await dataProvider.getDevices()
        }
    }
}
