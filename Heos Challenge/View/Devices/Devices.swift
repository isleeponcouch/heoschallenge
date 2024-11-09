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
                VStack {
                    Text("Rooms")
                        .font(.title3)
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    }
                    ScrollView(.vertical) {
                        ForEach(viewModel.devices, id: \.self) { device in
                            deviceCard(device)
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
    
    @ViewBuilder
    func deviceCard(_ device: Device) -> some View {
        Button {
            viewModel.selected = device
            viewModel.appState.selectedRoom = device.id
        } label: {
            VStack {
                Text(device.name)
                if let nowPlaying = device.nowPlaying {
                    Text(nowPlaying.artistName)
                    Text(nowPlaying.trackName)
                } else {
                    Text("No playing")
                }
                Spacer()
            }
            .padding(20)
            .background(deviceCardBackground(device))
        }
    }
    
    @ViewBuilder func deviceCardBackground(_ device: Device) -> some View {
        if let selected = viewModel.selected, selected == device  {
            RoundedRectangle(cornerRadius: 20).foregroundStyle(.blue)
        } else {
            RoundedRectangle(cornerRadius: 20).foregroundStyle(.green)
        }
    }
}

//extension Devices {
//
//}
//
//#Preview {
//    Devices()
//}
