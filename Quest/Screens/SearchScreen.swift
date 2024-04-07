//
//  SearchScreen.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 07/04/24.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var value: String = ""
    @FocusState private var isSearchBarFocused: Bool
    
    @State var showAllSources = false
    @State var showAllPlaces = false
    
    @State var thread: Thread
    
    private var initQuery: String? = nil
    
    @EnvironmentObject var thread_manager: ThreadManager
    
    init(query: String? = nil) {
        self.thread = Thread()
        self.initQuery = query
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scroll in
                ZStack {
                    ScrollView {
                        ForEach(Array(thread.searches.enumerated()), id: \.offset) { index, search in
                            SearchView(search: search)
                                .id(index)
                            
                            if (index < thread.searches.count - 1) {
                                Divider()
                                    .padding(.top, 6)
                                    .padding(.bottom, 6)
                            } else if !thread.isLoading && search.followUps != nil {
                                FollowUp(followUps: search.followUps!) { followUp in
                                    Task {
                                        await thread.search(query: followUp)
                                    }
                                    if (thread.searches.count > 1) {
                                        scroll.scrollTo(thread.searches.count - 1, anchor: .top)
                                    }
                                }
                                    .padding(.horizontal, 12)
                                    .padding(.top, 18)
                            }
                        }
                        .padding(.bottom, 150)
                    }
                    
                    if !thread.isLoading {
                        VStack {
                            Spacer()
                            SearchBar(value: $value, label: thread.searches.isEmpty ? "Search"
                                      : "Follow up", isSearchBarFocused: _isSearchBarFocused) {
                                let _ = print("On Submit")
                                let v = "\(value)"
                                Task {
                                    await thread.search(query: v)
                                }
                                if (thread.searches.count > 1) {
                                    scroll.scrollTo(thread.searches.count - 1, anchor: .top)
                                }
                                value = ""
                                isSearchBarFocused = false
                            }
                                .padding(.bottom, geometry.safeAreaInsets.bottom)
                                .background(
                                    Rectangle()
                                        .fill(.background)
                                        .mask {
                                            VStack(spacing: 0) {
                                                LinearGradient(
                                                    colors: [
                                                        Color.black.opacity(1),
                                                        Color.black.opacity(0),
                                                    ],
                                                    startPoint: .bottom,
                                                    endPoint: .top
                                                )
                                                Rectangle()
                                            }
                                        }
                                )
                        }
                        .ignoresSafeArea(.all, edges: .all)
                        .transition(.blurReplace)
                    }
                }
            }
        }
        .onAppear {
            thread.thread_manager = thread_manager
        }
        .task {
            if let query = initQuery {
                await thread.search(query: query)
            }
        }
    }
}

#Preview {
    SearchScreen()
}
