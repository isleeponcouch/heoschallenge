//
//  Container.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

struct Container: View {
    private enum HeosTab: Int {
        case Rooms
        case NowPlaying
        case Settings
        
        var label: String {
            switch self {
            case .Rooms:
                "Rooms"
            case .NowPlaying:
                "Now Playing"
            case .Settings:
                "Settings"
            }
        }
    }
    
    @Environment(AppState.self) private var appState
    @State private var selectedTab = HeosTab.NowPlaying
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Devices(appState: appState)
                .tag(HeosTab.Rooms)
                .tabItem {
                    Label(HeosTab.Rooms.label, systemImage: "square.split.bottomrightquarter.fill")
                }
            
            NowPlayingView(appState: appState)
                .tag(HeosTab.NowPlaying)
                .tabItem {
                    Label(HeosTab.NowPlaying.label, systemImage: "square.split.bottomrightquarter.fill")
                }
            
            Settings(appState: appState)
                .tag(HeosTab.Settings)
                .tabItem {
                    Label(HeosTab.Settings.label, systemImage: "square.split.bottomrightquarter.fill")
                }
        }
    }
}

#Preview {
    Container()
}
