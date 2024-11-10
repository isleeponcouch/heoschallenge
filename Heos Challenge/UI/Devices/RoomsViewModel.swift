//
//  DevicesViewModel.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

extension Rooms {
    
    @Observable
    class ViewModel: BaseViewModel {
        var allDevices: [Device] = []
        var allNowPlaying: [NowPlaying] = []
        
        var selected: Device? {
            didSet {
                appState.selectedRoom = selected
            }
        }
        
        func isPlaying(device: DeviceId) -> Bool {
            return appState.playingState.isPlaying(device: device)
        }
        
        func loadData() async {
            isLoading = true; defer { isLoading = false }
            
            do {
                let allDevicesResponse = try await dataProvider.getDevices()
                
                allNowPlaying = try await dataProvider.getNowPlaying()
                
                allDevices = allDevicesResponse.map { device in
                    if let playingForDevice = allNowPlaying.first(where: { nowPlaying in
                        nowPlaying.deviceId == device.id
                    }) {
                        return Device(id: device.id, name: device.name, nowPlaying: playingForDevice)
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
