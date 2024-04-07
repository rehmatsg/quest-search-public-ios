//
//  ArticleCard.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 01/04/24.
//

import SwiftUI
import Glur

struct ArticleCard: View {
    
    var article: Article
    
    init(article: Article? = nil) {
        if article != nil {
            self.article = article!
        } else {
            self.article = Article.sample()!
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: article.thumbnail)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .background(.ultraThinMaterial)
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text(article.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                
                if article.summary != nil {
                    Text(article.summary!)
                        .foregroundStyle(.secondary)
                        .font(.callout)
                        .lineLimit(2)
                }
                
                HStack(spacing: 6) {
                    if article.favicon != nil {
                        AsyncImage(url: URL(string: article.favicon!)) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Rectangle()
                                .background(.ultraThinMaterial)
                        }
                        .frame(width: 15, height: 15)
                        .clipShape(Circle())
                    }
                    
                    Text((article.sitename ?? article.hostname) + (article.publish_date != nil ? (" • \(article.publish_date!.timeAgo()) ago") : ""))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    VStack {
        ArticleCard()
            .padding(.horizontal, 12)
    }
}
