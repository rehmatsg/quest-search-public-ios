//
//  Knowledge.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 24/03/24.
//

import SwiftUI
import Glur
import SwiftUIGradientBlur
import Awesome

struct KnowledgePanel: View {
    
    var knowledge: Knowledge
    
    @Environment(\.openURL) private var openURL
    
    @State private var showAllAttributes = false
    
    private var maxAttributesShown = 3
    
    init(knowledge: Knowledge) {
        self.knowledge = knowledge
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: knowledge.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.secondary)
                }
                    .frame(height: 240)
                    .glur(
                        radius: 5,
                        offset: 0.3,
                        interpolation: 1
                    )
                    .overlay {
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black, location: -0.2),
                                .init(color: .clear, location: 0.6)
                            ]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    }
                    .clipped()
                
                VStack(alignment: .leading, spacing: -5) {
                    Text(
                        knowledge.label
                    )
                    .font(.title3)
                    .foregroundStyle(.white)
                    
                    Text(
                        knowledge.description
                    )
                    .font(.callout)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white.opacity(0.7))
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
            }
            
            ForEach(Array(knowledge.attributes.keys.enumerated()), id: \.element) { index, key in
                if showAllAttributes || index < maxAttributesShown {
                    HStack {
                        Text(key)
                            .foregroundStyle(.secondary)
                            .frame(width: 120, alignment: .leading)
                        Text(convertToString(knowledge.attributes[key]))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.text)
                        Spacer()
                    }
                    .padding(.vertical, 2)
                    .padding(.horizontal, 12)
                    .transition(.blurReplace)
                }
            }
            
            if (knowledge.attributes.count > maxAttributesShown) {
                Button(action: {
                    withAnimation {
                        showAllAttributes.toggle()
                    }
                }) {
                    HStack {
                        Text(showAllAttributes ? "View Less" : "View More")
                            .contentTransition(.identity)
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(showAllAttributes ? 180 : 0))
                    }
                }
                .padding(.horizontal, 12)
                .foregroundStyle(.secondary)
            }
            
            if knowledge.website != nil {
                VStack {
                    HStack {
                        Image(systemName: "safari")
                        VStack(alignment: .leading, spacing: 0) {
                            Text(getHostname(from: knowledge.website!) ?? knowledge.website!)
                                .foregroundStyle(.secondary)
                                .font(.caption)
                            Text("Official Website")
                                .font(.callout)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color.secondaryBackground)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .onTapGesture {
                    openURL(URL(string: knowledge.website!)!)
                }
                .padding(.horizontal, 12)
            }
            
        }
    }
    
    func convertToString(_ v: Any?) -> String {
        guard let value = v else {
            return "Unknown"
        }
        
        switch value {
        case let intValue as Int:
            return String(intValue)
        case let stringValue as String:
            let dateFormatter = ISO8601DateFormatter()
            if let date = dateFormatter.date(from: stringValue) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "d MMMM yyyy"
                return outputFormatter.string(from: date)
            } else {
                return stringValue
            }
        case let listValue as [String]:
            if listValue.count > 5 {
                let firstTenItems = listValue.prefix(5).map { $0.capitalizingFirstLetter() }.joined(separator: ", ")
                let remainingCount = listValue.count - 5
                return "\(firstTenItems), and \(remainingCount) more"
            } else {
                return listValue.map { $0.capitalizingFirstLetter() }.joined(separator: ", ")
            }
        default:
            return "\(value)"
        }
    }
    
    func getHostname(from urlString: String) -> String? {
        guard let url = URL(string: urlString), let hostname = url.host else {
            print("Invalid URL")
            return nil
        }
        return hostname
    }
}

#Preview {
    ScrollView {
        KnowledgePanel(knowledge: Knowledge.sample()!)
    }
}
