//
//  LoadingView.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 9/11/2024.
//

import SwiftUI

struct LoadingView: View {
    private var sourceIsMockData: Bool
    
    init(sourceIsMockData: Bool) {
        self.sourceIsMockData = sourceIsMockData
    }
    
    var body: some View {
        ZStack {
            Color.black
            ProgressView {
                Text("Loading from \(sourceIsMockData ? "local mock data" : "the cloud").")
                    .font(.caption)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    LoadingView(sourceIsMockData: true)
}
