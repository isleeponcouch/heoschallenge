//
//  NowPlaying.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

struct NowPlayingView: View {
    @State private var viewModel: ViewModel
    
    init(appState: AppState) {
        self.viewModel = ViewModel(appState: appState)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView(sourceIsMockData: viewModel.appState.useMockData)
            } else {
                VStack {
                    Text("Now Playing")
                        .fontWeight(.semibold)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    }
                    
                    if let selected = viewModel.showing {
                        VStack {
                            CoverArt(url: selected.artworkLargeURL, size: 300, cornerRadius: 20)
                            
                            Text(selected.trackName)
                                .fontWeight(.semibold)
                            Text(selected.artistName)
                                .font(.caption)
                            
                            Button {
                                viewModel.appState.playingState.setPlayingState(for: selected.deviceId, toPlaying: !viewModel.showingIsPlaying)
                            } label: {
                                Image(systemName: viewModel.showingIsPlaying ? "pause.fill" : "play.fill")
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    let playing = NowPlaying(
        deviceId: 1,
        artworkSmallURL: URL(string: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+small.jpg")!,
        artworkLargeURL: URL(string: "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/Appetite+For+Destruction+-+large.jpg")!,
        trackName: "Welcome To The Jungle",
        artistName: "Guns N' Roses"
    )
    
    let state = AppState()
    state.selectedRoom = Device(id: 1, name: "Room", nowPlaying: playing)
    
    return NowPlayingView(appState: state)
}
