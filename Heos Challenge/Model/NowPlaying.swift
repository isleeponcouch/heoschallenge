//
//  NowPlaying.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import Foundation

struct NowPlayingResult: Codable {
    var nowPlaying: [NowPlaying]
    
    private enum CodingKeys: String, CodingKey {
        case nowPlaying = "Now Playing"
    }
}

struct NowPlaying: Codable, Hashable {
    var deviceId: DeviceId
    var artworkSmallURL: URL
    var artworkLargeURL: URL
    var trackName: String
    var artistName: String
    
    private enum CodingKeys: String, CodingKey {
        case deviceId = "Device ID"
        case artworkSmallURL = "Artwork Small"
        case artworkLargeURL = "Artwork Large"
        case trackName = "Track Name"
        case artistName = "Artist Name"
    }
}
