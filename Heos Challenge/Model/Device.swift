//
//  Devices.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import Foundation

struct DevicesResult: Codable {
    var devices: [Device]
    
    private enum CodingKeys: String, CodingKey {
        case devices = "Devices"
    }
}

struct Device: Codable, Hashable {
    var id: Int
    var name: String
    var nowPlaying: NowPlaying?
    
    public mutating func setNowPlying(_ nowPlaying: NowPlaying) {
        self.nowPlaying = nowPlaying
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}
