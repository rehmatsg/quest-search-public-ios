//
//  SourceView.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 26/03/24.
//

import SwiftUI

struct SourceView: View {
    
    var source: Source
    
    @Environment(\.openURL) var openURL
    
    init(source: Source) {
        self.source = source
    }
    
    var body: some View {
        HStack {
            Group {
                if source.favicon != nil {
                    AsyncImage(url: URL(string: source.favicon!)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle()
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                }
            }
            VStack(alignment: .leading, spacing: -3) {
                Text(source.hostname)
                    .foregroundStyle(.secondary)
                    .font(.caption)
                Text(source.title)
                    .font(.callout)
            }
            .lineLimit(1)
            .truncationMode(.tail)
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(width: UIScreen.main.bounds.size.width * 2/3)
        .background(Color.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onTapGesture {
            openURL(URL(string: source.url)!)
        }
    }
}

struct FeaturedSourceView: View {
    
    @Environment(\.openURL) var openURL
    
    var source: Source
    
    init(source: Source) {
        self.source = source
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if source.thumbnail != nil {
                AsyncImage(url: URL(string: source.thumbnail!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.secondary)
                        .frame(height: (UIScreen.screenWidth * 2/3) - 24)
                }
                .frame(width: UIScreen.screenWidth - 24)
                .frame(maxHeight: (UIScreen.screenWidth * 1/3) - 24)
                .clipShape(Rectangle())
            }
            
            HStack {
                if source.favicon != nil {
                    AsyncImage(url: URL(string: source.favicon!)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle()
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 15, height: 15)
                    .clipShape(Circle())
                }
                Text(source.hostname)
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            .padding(.horizontal, 12)
            .padding(.top, 12)
            
            Text(source.title)
                .font(.body)
                .fontWeight(.semibold)
                .lineLimit(2)
                .padding(.horizontal, 12)
                .padding(.top, 3)
            
            if source.summary != nil {
                Text(truncateString(source.summary!))
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .padding(.horizontal, 12)
            }
        }
        .padding(.bottom, 12)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.secondaryBackground)
        )
        .onTapGesture {
            openURL(URL(string: source.url)!)
        }
    }
    
    func truncateString(_ input: String, toLength length: Int = 150) -> String {
        guard input.count > length else { return input }
        let index = input.index(input.startIndex, offsetBy: length)
        return String(input[..<index]) + "..."
    }
    
}

struct DetailedSourceView: View {
    
    @Environment(\.openURL) var openURL
    
    var source: Source
    
    init(source: Source) {
        self.source = source
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Group {
                    if source.favicon != nil {
                        AsyncImage(url: URL(string: source.favicon!)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Circle()
                                .foregroundColor(.secondary)
                        }
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                    }
                }
                VStack(alignment: .leading, spacing: -3) {
                    Text(source.hostname)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    Text(source.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                }
                Spacer()
            }
            HStack {
                Circle()
                    .foregroundColor(.clear)
                    .frame(width: 25, height: 25)
                if source.description != nil {
                    Text(truncateString(source.description!))
                        .font(.callout)
                        .foregroundStyle(Color.text)
                        .lineLimit(4)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 12)
        .frame(width: UIScreen.main.bounds.size.width)
        .onTapGesture {
            openURL(URL(string: source.url)!)
        }
    }
    
    func truncateString(_ input: String, toLength length: Int = 150) -> String {
        guard input.count > length else { return input }
        let index = input.index(input.startIndex, offsetBy: length)
        return String(input[..<index]) + "..."
    }
    
}

#Preview {
    VStack {
        SourceView(source: Source.sample()!)
        DetailedSourceView(source: Source.sample()!)
        FeaturedSourceView(source: Source.sample()!)
            .padding(.horizontal, 12)
    }
}
