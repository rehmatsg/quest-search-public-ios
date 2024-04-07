//
//  SearchLocationView.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 29/03/24.
//

import SwiftUI

struct SearchLocationView: View {
    
    var location: String
    
    var body: some View {
        HStack(spacing: 9) {
            Image(systemName: "location.fill")
                .font(.title3)
            VStack(alignment: .leading, spacing: -3) {
                Text("Showing results near")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(location)
                    .fontDesign(.rounded)
                    .font(.headline)
            }
            Spacer()
        }
    }
}

#Preview {
    SearchLocationView(location: "San Francisco")
        .padding(.horizontal, 20)
}
