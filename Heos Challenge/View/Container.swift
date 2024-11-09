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
        
        var systemImage: String {
            switch self {
            case .Rooms:
                return "square.split.bottomrightquarter.fill"
            case .NowPlaying:
                return "play.square"
            case .Settings:
                return "gear"
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
                    Label(HeosTab.Rooms.label, systemImage: HeosTab.Rooms.systemImage)
                }
            
            NowPlayingView(appState: appState)
                .tag(HeosTab.NowPlaying)
                .tabItem {
                    Label(HeosTab.NowPlaying.label, systemImage: HeosTab.NowPlaying.systemImage)
                }
            
            Settings(appState: appState)
                .tag(HeosTab.Settings)
                .tabItem {
                    Label(HeosTab.Settings.label, systemImage: HeosTab.Settings.systemImage)
                }
        }
    }
}

#Preview {
    Container()
}
