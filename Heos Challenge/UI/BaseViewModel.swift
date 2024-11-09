//
//  BaseViewModel.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 8/11/2024.
//

import SwiftUI

@Observable class BaseViewModel {
    var appState: AppState
    var isLoading = true
    var errorMessage: String?
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    internal var dataProvider: DataProvider {
        appState.useMockData ? LocalDataProvider() : CloudDataProvider(apiClient: ApiClient())
    }
}
