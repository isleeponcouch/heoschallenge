//
//  TabbedBrowser.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

struct TabbedBrowser: View {
    private enum Tab: Int {
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
    @State private var selectedTab = Tab.NowPlaying
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Rooms(appState: appState)
                .tag(Tab.Rooms)
                .tabItem {
                    Label(Tab.Rooms.label, systemImage: Tab.Rooms.systemImage)
                }
            
            NowPlayingView(appState: appState)
                .tag(Tab.NowPlaying)
                .tabItem {
                    Label(Tab.NowPlaying.label, systemImage: Tab.NowPlaying.systemImage)
                }
            
            Settings(appState: appState)
                .tag(Tab.Settings)
                .tabItem {
                    Label(Tab.Settings.label, systemImage: Tab.Settings.systemImage)
                }
        }
    }
}

#Preview {
    TabbedBrowser()
}
