//
//  Search.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 24/03/24.
//

import SwiftUI

struct Home: View {
    
    @State private var value: String = ""
    @FocusState private var isSearchBarFocused: Bool
    
    let suggestedSearches = [
        "Discover Restaurants": "What are some good restaurants near me?",
        "Solar Eclispe": "Tell me about the next solar eclipse",
        "iOS 18 Rumours": "What are the rumoured iOS 18 features",
        "Tesla Robotoxi": "What is the recent Tesla Robotaxi announcement",
        "Moon's Timezone": "Is Moon getting a timezone"
    ]
    
    private var onSearch: ((_ query: String) -> Void)?
    
    init(onSearch: ((_ query: String) -> Void)? = nil) {
        self.onSearch = onSearch
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            Spacer()
            
            Text("Quest")
                .font(.custom("Unbounded", size: 40))
                .italic()
                .fontWeight(.black)
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(suggestedSearches.sorted(by: >), id: \.key) { key, value in
                        VStack(alignment: .leading, spacing: 0) {
                            Text(key)
                                .font(.body)
                                .fontDesign(.rounded)
                                .fontWeight(.semibold)
                            Text(value)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: UIScreen.screenWidth * 2/3)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 12)
                        .background(Color.secondaryBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            if onSearch != nil {
                                onSearch!(value)
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            SearchBar(value: $value, label: "Search", isSearchBarFocused: _isSearchBarFocused) {
                if onSearch != nil {
                    onSearch!(value)
                    value = ""
                }
            }
            .padding(.bottom, 12)
        }
    }
}

#Preview {
    Home()
}
