//
//  AppState.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

@Observable
class AppState {
    var useMockData = false
    var selectedRoom: Device?
    var selectedTrack: NowPlaying?
    var playingState = PlayingState()
}

@Observable
class PlayingState {
    var playingStates: [DeviceId: Bool] = [:]
    
    public func setPlayingState(for device: DeviceId, toPlaying: Bool) {
        playingStates[device] = toPlaying
    }
    
    public func isPlaying(device: DeviceId) -> Bool {
        return playingStates[device] ?? false
    }
}
