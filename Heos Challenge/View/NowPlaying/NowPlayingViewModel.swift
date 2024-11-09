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
        var nowPlaying: [NowPlaying] = []
        var selected: NowPlaying?
        
        public func loadData() async {
            isLoading = true
            
            defer {
                isLoading = false
            }
            
            do {
                nowPlaying = try await dataProvider.getNowPlaying()
            } catch {
                errorMessage = "Problem loading now playing data \(error.localizedDescription)"
            }
        }
        
        public func setSelected() {
            if let now = nowPlaying.first(where: { n in
                n.deviceId == appState.selectedRoom?.id
            }) {
                selected = now
            }
        }
    }
}
