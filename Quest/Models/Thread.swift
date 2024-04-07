//
//  Thread.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 28/03/24.
//

import Foundation

class ThreadManager: ObservableObject {
    @Published var threads: [Thread] = []
    
    func addOrUpdateThread(_ thread: Thread) {
        if let index = threads.firstIndex(where: { $0.id == thread.id }) {
            threads[index] = thread // Replace the existing thread with the updated one
        } else {
            threads.append(thread) // Add new thread
        }
    }
}

@Observable
class Thread {
    
    var id: String?
    var searches: [Search] = []
    private var _currentSearch: Search?
    
    var isLoading: Bool = false
    
    var created_at: Date = Date.now
    
    var thread_manager: ThreadManager?
    
    func search(query: String) async {
        print(query)
        
        isLoading = true
        
        let newSearch = Search(query: query)
        _currentSearch = newSearch
        _currentSearch?.isLoading = true
        searches.append(newSearch)
        
        let baseURL = "https://quest-search-production.up.railway.app/search"
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
        ]
        
        if id != nil {
            components?.queryItems?.append(URLQueryItem(name: "thread_id", value: id))
        }
        
        guard let urlWithParams = components?.url else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: urlWithParams)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        do {
            let (stream, _) = try await URLSession.shared.bytes(for: request)

            for try await line in stream.lines {
                guard let message = jsonToDictionary(from: line) else { continue }
                
                if message.keys.contains("thread_id") && message["thread_id"] != nil {
                    id = message["thread_id"] as? String
                }

                _currentSearch?.handleDataReceive(message)
            }
            
            _currentSearch?.isLoading = false
            
            isLoading = false
            _currentSearch = nil
            
            thread_manager?.addOrUpdateThread(self)
        } catch {
            isLoading = false
            _currentSearch = nil
            searches.removeLast()
        }
    }
    
}

extension Thread: Equatable, Identifiable {
    static func == (lhs: Thread, rhs: Thread) -> Bool {
        lhs.id == rhs.id
    }

    var identifier: String {
        id ?? UUID().uuidString // Consider a non-optional ID for better practice
    }
}
