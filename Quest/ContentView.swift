//
//  ContentView.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 24/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var path: [String] = []
    
    @State var thread_manager: ThreadManager = ThreadManager()
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                Home() { query in
                    path = [query]
                }
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                Discover()
                    .navigationTitle(Text("Discover"))
                    .tabItem {
                        Label("Discover", systemImage: "safari")
                    }
                
                ThreadHistory()
                    .navigationTitle(Text("Library"))
                    .tabItem {
                        Label("Library", systemImage: "rectangle.stack.fill")
                    }
            }
            .navigationDestination(for: String.self) { query in
                SearchScreen(query: query)
            }
        }
        .environmentObject(thread_manager)
    }
}

#Preview {
    ContentView()
}

