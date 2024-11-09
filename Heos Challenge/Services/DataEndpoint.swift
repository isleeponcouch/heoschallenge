//
//  DataEndpoint.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 9/11/2024.
//

import Foundation

enum DataEndpoint: String {
    case devices = "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/devices.json"
    case nowPlayings = "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/nowplaying.json"
    
    var url: URL {
        guard let url = URL(string: self.rawValue) else {
            fatalError("Malformed endpoint URL string. This is programmer error.")
        }
        
        return url
    }
    
    static var localLocations: [String: URL] {
        [self.devices.rawValue: Bundle.main.url(forResource: "devices", withExtension: "json")!]
    }
}
