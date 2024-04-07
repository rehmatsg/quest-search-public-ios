//
//  FollowUp.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 26/03/24.
//

import SwiftUI

struct FollowUp: View {
    
    var followUps: [String]
    
    var onTap: ((String) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "rectangle.stack")
                    .font(.callout)
                Text("Follow Up")
                    .font(.title3)
            }
            .foregroundStyle(.primary)
            .padding(.bottom, 12)
            
            ForEach(Array(followUps.enumerated()), id: \.element) { index, followUp in
                HStack {
                    Text(followUp)
                        .foregroundStyle(Color.text)
                    Spacer()
                    Image(systemName: "plus")
                        .foregroundColor(.accentColor)
                }
                .onTapGesture {
                    self.onTap?(followUp)
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                        impactMed.impactOccurred()
                }
                if index < followUps.count - 1 {
                    Divider()
                        .padding(.bottom, 9)
                        .padding(.top, 9)
                }
            }
        }
    }
}

#Preview {
    FollowUp(followUps: [
        "What is Loopt and how did it perform in the market?",
        "What were the circumstances around Sam Altman's departure and reinstatement at OpenAI's board?",
        "Can you tell me more about OpenAI and its mission?"
    ])
        .padding(.horizontal, 20)
}
