//
//  ImageView.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 02/04/24.
//

import SwiftUI

struct ImageView: View {
    
    var source: Source
    
    @Environment(\.openURL) var openURL
    
    init(source: Source) {
        self.source = source
    }
    
    var body: some View {
        AsyncImage(url: URL(string: source.thumbnail!)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.secondary)
                .frame(width: 300)
        }
        .frame(height: 200)
        .frame(maxWidth: 300)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ImageView(source: Source.sample()!)
}
