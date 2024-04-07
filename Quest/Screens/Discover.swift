//
//  Home.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 02/04/24.
//

import SwiftUI

struct Discover: View {
    @State private var articlesByTopic: [String: [Article]] = [:]
    @State private var selectedTopic: String = "TECHNOLOGY"
    @State private var isLoading: Bool = true
    
    // To ensure that topics are ordered and unique for the Picker
    private var topics: [String] {
        Array(articlesByTopic.keys).sorted()
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    topicPicker
                    articlesView
                }
            }
            .navigationTitle("Discover")
            .task {
                articlesByTopic = await Article.getFeed()
                isLoading = false
            }
        }
    }
    
    private var topicPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(topics, id: \.self) { topic in
                    Chip(
                        text: topic.toTitleCase(),
                        isSelected: selectedTopic == topic
                    ) {
                        selectedTopic = topic
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(.bottom, 12)
    }
    
    private var articlesView: some View {
        LazyVStack {
            if isLoading {
                ForEach(1...5, id: \.self) { index in
                    ArticleCard()
                        .padding(.horizontal, 12)
                        .redacted(reason: .placeholder)
                }
            } else {
                ForEach(articlesByTopic[selectedTopic] ?? [], id: \.id) { article in
                    ArticleCard(article: article)
                        .padding(.horizontal, 12)
                    Divider()
                        .padding(.horizontal, 18)
                }
            }
        }
    }
}


#Preview {
    Discover()
}
