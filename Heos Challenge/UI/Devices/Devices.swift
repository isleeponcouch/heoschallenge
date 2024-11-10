//
//  Devices.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

struct Devices: View {
    @State private var viewModel: DevicesViewModel
    
    init(appState: AppState) {
        self.viewModel = DevicesViewModel(appState: appState)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView(sourceIsMockData: viewModel.appState.useMockData)
            } else {
                VStack(alignment: .leading) {
                    Text("Rooms")
                        .font(.title)
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    }
                    ScrollView(.vertical) {
                        ForEach(viewModel.allDevices, id: \.self) { device in
                            deviceCard(device)
                        }
                    }
                    Spacer()
                }
                .padding(10)
            }
        }
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
    
    @ViewBuilder
    func deviceCard(_ device: Device) -> some View {
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
                    }
                    Spacer()
                } else {
                    Text("Silence is golden.")
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.black)
            .background(deviceCardBackground(device))
        }
    }
    
    @ViewBuilder func deviceCardBackground(_ device: Device) -> some View {
        if let selected = viewModel.selected, selected == device  {
            RoundedRectangle(cornerRadius: 16).foregroundStyle(.secondary)
        } else {
            RoundedRectangle(cornerRadius: 16).foregroundStyle(.tertiary)
        }
    }
}

#Preview {
    Devices(appState: AppState())
}
