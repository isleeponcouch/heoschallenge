//
//  ApiClient.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import Foundation
import OSLog
import SwiftUI

enum ApiException: Error  {
    case HTTPResponseError
}

class ApiClient {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    private var config: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        return config
    }
    
    @discardableResult
    func request<T: Codable>(entity: T.Type, fromEndpoint endpoint: URL) async throws -> T {
        Logger().info("Performing request for type \(entity.self) from endpoint: \(endpoint)")
        
        let url = endpoint
        let request = URLRequest(url: url)
        let session = URLSession(configuration: config)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ApiException.HTTPResponseError
        }
        
#if DEBUG
        try await Task.sleep(nanoseconds: 2_000_000_000) // for testing the loading screen
#endif
        
        return try decoder.decode(T.self, from: data)
    }
}
