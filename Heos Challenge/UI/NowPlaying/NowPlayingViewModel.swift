//
//  NowPlayingViewModel.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import Foundation

extension NowPlayingView {
    
    @Observable
    class ViewModel: BaseViewModel {
        var allNowPlaying: [NowPlaying] = []
        var showing: NowPlaying?
        
        var showingIsPlaying: Bool {
            if let showing = showing {
                return appState.playingState.isPlaying(device: showing.deviceId)
            }
            
            return false
        }
        
        func setPlaying(_ playing: Bool, deviceId: DeviceId) {
            appState.playingState.setPlayingState(for: deviceId, toPlaying: playing)
        }
        
        func loadData() async {
            isLoading = true; defer { isLoading = false }
            
            do {
                allNowPlaying = try await dataProvider.getNowPlaying()
                showPlayingFromSelectedRoomOrDefault()
            } catch {
                errorMessage = "Problem loading now playing data \(error.localizedDescription)"
            }
        }
        
        private func showPlayingFromSelectedRoomOrDefault() {
            if let now = allNowPlaying.first(where: { n in
                n.deviceId == appState.selectedRoom?.id
            }) {
                showing = now
            } else {
                showing = allNowPlaying.first
            }
        }
    }
}
