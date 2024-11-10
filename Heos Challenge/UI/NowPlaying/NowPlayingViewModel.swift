//
//  NowPlayingViewModel.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import Foundation

extension NowPlayingView {
    
    @Observable
    class NowPlayingViewModel: BaseViewModel {
        var allNowPlaying: [NowPlaying] = []
        var showing: NowPlaying?
        
        public func loadData() async {
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
