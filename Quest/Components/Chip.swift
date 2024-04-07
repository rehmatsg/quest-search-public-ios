//
//  Chip.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 02/04/24.
//

import SwiftUI

struct Chip: View {
    let text: String
    var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        Text(text)
            .fontDesign(.rounded)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.accentColor : Color.secondaryBackground)
            .transition(.opacity)
            .foregroundColor(isSelected ? .white : .primary)
            .clipShape(Capsule())
            .onTapGesture {
                withAnimation {
                    onTap()
                }
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
    }
}

struct ChipPreview: View {
    
    @State private var currentlySelected: String = "LATEST"
    
    var topics = ["LATEST", "WORLD", "NATION", "BUSINESS", "TECHNOLOGY", "ENTERTAINMENT", "SPORTS", "SCIENCE", "HEALTH"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(topics, id: \.self) { topic in
                    Chip(text: topic.capitalized, isSelected: currentlySelected == topic) {
                        // This closure is called when the Chip is tapped.
                        withAnimation {
                            currentlySelected = topic
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ChipPreview()
}
