//
//  CoverArt.swift
//  Heos Challenge
//
//  Created by Tobi Gundry on 9/11/2024.
//

import SwiftUI

struct CoverArt: View {
    private var url: URL
    private var size: CGFloat
    private var cornerRadius: CGFloat
    
    init(url: URL, size: CGFloat, cornerRadius: CGFloat) {
        self.url = url
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable().scaledToFill().clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } placeholder:  {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundStyle(.gray)
                ProgressView()
            }
        }
        .frame(maxWidth: size, maxHeight: size)
        .clipped()
    }
}
