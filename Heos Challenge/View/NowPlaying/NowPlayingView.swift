//
//  NowPlaying.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

struct NowPlayingView: View {
    @State private var viewModel: NowPlayingViewModel
    
    init(appState: AppState) {
        self.viewModel = NowPlayingViewModel(appState: appState)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView(sourceIsMockData: viewModel.appState.useMockData)
            } else {
                VStack {
                    Text("Now Playing")
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    }
                    
                    if let selected = viewModel.selected {
                        VStack {
                            AsyncImage(url: selected.artworkLargeURL) { image in
                                image.resizable().scaledToFill().clipShape(RoundedRectangle(cornerRadius: 20))
                            } placeholder:  {
                                RoundedRectangle(cornerRadius: 20).foregroundStyle(.gray)
                            }
                            .frame(maxWidth: 300, maxHeight: 300)
                            .clipped()
                            Text(selected.artistName)
                            Text(selected.trackName)
                            
                            Button {
                                
                            } label: {
                                
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.loadData()
                viewModel.setSelected()
            }
        }
    }
}

//#Preview {
//    NowPlaying()
//}
