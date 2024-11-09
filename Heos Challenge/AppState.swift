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
    var isPaused = false
    var selectedRoom = 1
    var selectedTrack: NowPlaying?
}
