//
//  DataProvider.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import Foundation

enum DataEndpoint: String {
    enum Location {
        case cloud
        case local
    }
    
    case devices = "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/devices.json"
    case nowPlayings = "https://skyegloup-eula.s3.amazonaws.com/heos_app/code_test/nowplaying.json"
    
    func url(_ from: Location) -> URL {
        switch self {
            
        case .devices:
            return from == .cloud ? URL(string: self.rawValue)! : Self.localLocations[self.rawValue]!
        case .nowPlayings:
            return from == .cloud ? URL(string: self.rawValue)! : Self.localLocations[self.rawValue]!
        }
    }
    
    static var localLocations: [String: URL] {
        [self.devices.rawValue: Bundle.main.url(forResource: "devices", withExtension: "json")!]
    }
}

protocol DataProvider {
    func getDevices() async throws -> [Device]
    func getNowPlaying() async throws -> [NowPlaying]
}

class CloudDataProvider: DataProvider {
    private var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getDevices() async throws -> [Device] {
        try await apiClient.request(entity: DevicesResult.self, fromEndpoint: DataEndpoint.devices.url(.cloud)).devices
    }
    
    func getNowPlaying() async throws -> [NowPlaying] {
        try await apiClient.request(entity: NowPlayingResult.self, fromEndpoint: DataEndpoint.nowPlayings.url(.cloud)).nowPlaying
    }
}

class LocalDataProvider: DataProvider {
    enum LocalDataProviderError: Error {
        case DataFileNotFound
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func getDevices() async throws -> [Device] {
        try resultFromLocalJson(type: DevicesResult.self, file: "devices").devices
    }
    
    func getNowPlaying() async throws -> [NowPlaying] {
        let result = try resultFromLocalJson(type: NowPlayingResult.self, file: "nowplaying").nowPlaying
        
        return replaceCloudUrlsWithLocalUrls(result)
    }
    
    private func replaceCloudUrlsWithLocalUrls(_ data: [NowPlaying]) -> [NowPlaying] {
        data.map {
            NowPlaying(
                deviceId: $0.deviceId,
                artworkSmallURL: localMockImageUrlFrom(cloudUrl: $0.artworkSmallURL),
                artworkLargeURL: localMockImageUrlFrom(cloudUrl: $0.artworkLargeURL),
                trackName: $0.trackName,
                artistName: $0.artistName
            )
        }
    }
    
    private func resultFromLocalJson<T: Codable>(type: T.Type, file: String) throws -> T {
        if let fileURL = Bundle.main.url(forResource: file, withExtension: "json") {
            let json = try Data(contentsOf: fileURL)
            return try decoder.decode(T.self, from: json)
        } else {
            throw LocalDataProviderError.DataFileNotFound
        }
    }
    
    private func localMockImageUrlFrom(cloudUrl url: URL) -> URL {
        let filename = url.lastPathComponent
        
        if let fileURL = Bundle.main.url(forResource: filename, withExtension: nil) {
            return fileURL
        }
        
        return Bundle.main.url(forResource: "default", withExtension: "png")!
    }
}
