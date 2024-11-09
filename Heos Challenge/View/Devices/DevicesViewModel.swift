//
//  DevicesViewModel.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

extension Devices {
    
    @Observable
    class DevicesViewModel: BaseViewModel {
        var devices: [Device] = []
        var selected: Device?
        var nowPlaying: [NowPlaying] = []
        
        public func loadData() async {
            isLoading = true
            
            defer { isLoading = false }
            
            do {
                devices = try await dataProvider.getDevices()
                nowPlaying = try await dataProvider.getNowPlaying()
                
                devices = devices.map { device in
                    if let playingForDevice = nowPlaying.first(where: { nowPlaying in
                        nowPlaying.deviceId == device.id
                    }) {
                        var dev = device
                        dev.nowPlaying = playingForDevice
                        return dev
                    } else {
                        return device
                    }
                }
            } catch {
                errorMessage = "Error loading devices \(error.localizedDescription)"
            }
        }
    }
}
