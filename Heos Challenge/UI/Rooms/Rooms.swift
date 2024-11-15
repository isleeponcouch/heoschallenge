//
//  Devices.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

struct Rooms: View {
    @State private var viewModel: ViewModel
    
    init(appState: AppState) {
        self.viewModel = ViewModel(appState: appState)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView(sourceIsMockData: viewModel.appState.useMockData)
            } else {
                rooms
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
    
    @ViewBuilder
    private var rooms: some View {
        VStack(alignment: .leading) {
            Text("Rooms")
                .font(.title)
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
            ScrollView(.vertical) {
                ForEach(viewModel.allDevices, id: \.self) { device in
                    roomCard(device)
                }
            }
            Spacer()
        }
        .padding(10)
    }
    
    @ViewBuilder
    private func roomCard(_ device: Device) -> some View {
        Button {
            viewModel.selected = device
        } label: {
            HStack {
                if let nowPlaying = device.nowPlaying {
                    CoverArt(url: nowPlaying.artworkSmallURL, size: 60, cornerRadius: 8)
                    VStack(alignment: .leading) {
                        Text(device.name)
                            .fontWeight(.semibold)
                        Text("\(nowPlaying.trackName), \(nowPlaying.artistName)")
                            .font(.caption)
                        Image(systemName: viewModel.isPlaying(device: device.id) ? "play.fill" : "stop.fill")
                    }
                    Spacer()
                } else {
                    Text("Silence is golden.")
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.black)
            .background(roomCardBackground(device))
        }
    }
    
    @ViewBuilder
    private func roomCardBackground(_ device: Device) -> some View {
        if let selected = viewModel.selected, selected == device  {
            RoundedRectangle(cornerRadius: 16).foregroundStyle(.secondary)
        } else {
            RoundedRectangle(cornerRadius: 16).foregroundStyle(.tertiary)
        }
    }
}

#Preview {
    Rooms(appState: AppState())
}
