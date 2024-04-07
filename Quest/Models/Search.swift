//
//  Search.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 28/03/24.
//

import Foundation
import SwiftUI

@Observable
class Search {
    
    var knowledge: Knowledge?
    var summary: String?
    var images: [Source]?
    var featured_source: Source?
    var sources: [Source]?
    var followUps: [String]?
    var places: [Place]?
    var query: String = ""
    var location: String?
    var isLoading: Bool = false
    
    init(query: String) {
        self.query = query
    }
    
    func handleDataReceive(_ dict: [String: Any?]) {
        if dict.keys.contains("query") && dict["query"] != nil {
            withAnimation {
                query = (dict["query"] as? String) ?? query
            }
        }
        
        if dict.keys.contains("location") && dict["location"] != nil {
            self.location = dict["location"] as? String
        }
        
        if dict.keys.contains("knowledge_panel") && dict["knowledge_panel"] != nil {
            withAnimation {
                do {
                    if let knowledgeValue: [String : Any?] = dict["knowledge_panel"] as? [String: Any?] {
                        self.knowledge = try Knowledge.fromDictionary(knowledgeValue)
                    }
                } catch {
                    print("Failed to build Knowledge Panel")
                }
            }
        }
        
        if dict.keys.contains("images") && dict["images"] != nil {
            withAnimation {
                do {
                    if images == nil {
                        images = []
                    }
                    for source in (dict["images"] as! [Any]) {
                        try images!.append(Source.fromDictionary(source as! [String: Any?]))
                    }
                } catch {
                    print("Failed to build Images")
                }
            }
        }
        
        if dict.keys.contains("sources") && dict["sources"] != nil {
            withAnimation {
                do {
                    if sources == nil {
                        sources = []
                    }
                    for source in (dict["sources"] as! [Any]) {
                        try sources!.append(Source.fromDictionary(source as! [String: Any?]))
                    }
                } catch {
                    print("Failed to build Sources")
                }
            }
        }
        
        if dict.keys.contains("featured_source") && dict["featured_source"] != nil {
            withAnimation {
                do {
                    if let fs = dict["featured_source"] as? [String : Any?] {
                        featured_source = try Source.fromDictionary(fs)
                    }
                } catch {
                    print("Failed to build Sources")
                }
            }
        }
        
        if dict.keys.contains("places") && dict["places"] != nil {
            do {
                if places == nil {
                    places = []
                }
                for place in (dict["places"] as! [Any]) {
                    try places!.append(Place.fromDictionary(place as! [String: Any?]))
                }
            } catch {
                print("Failed to build Places")
            }
        }
        
        if dict.keys.contains("delta") && dict["delta"] != nil {
            if summary == nil {
                summary = ""
            }
            let summaryDelta: String = (dict["delta"] as! [String: Any?])["summary"] as! String
            summary! += summaryDelta
        }
        
        if dict.keys.contains("summary") && dict["summary"] != nil {
            withAnimation {
                summary = dict["summary"] as? String
            }
        }
        
        if dict.keys.contains("follow_ups") && dict["follow_ups"] != nil {
            followUps = dict["follow_ups"] as? [String]
        }
    }
    
    func insertSampleQuery() {
        withAnimation {
            query = "Who is Sam Altman"
        }
    }
    
    func insertSampleSources() {
        withAnimation {
            sources = [Source.sample()!, Source.sample()!, Source.sample()!]
        }
    }
    
    func insertSampleImages() {
        withAnimation {
            images = [Source.sample()!, Source.sample()!, Source.sample()!]
        }
    }
    
    func insertSampleKnowledgePanel() {
        withAnimation {
            knowledge = Knowledge.sample()
        }
    }
    
    func insertSampleSummary() {
        withAnimation {
            summary = getSampleSummary()
        }
    }
    
    func insertSampleFollowUps() {
        withAnimation {
            followUps = [
                "How old is Sam Altman",
                "What was Sam's role in OpenAI",
                "Why was Sam Altman fired from OpenAI"
            ]
        }
    }
    
    static func sampleSearch() -> Search {
        let search = Search(query: "Who is Sam Altman?")
        search.sources = [Source.sample()!, Source.sample()!, Source.sample()!]
        search.featured_source = Source.sample()!
        search.summary = getSampleSummary()
        
        return search
    }
    
    static func sampleLoadingSearch() -> Search {
        let search = Search(query: "Who is Sam Altman?")
        search.isLoading = true
        
        return search
    }
    
    static func sampleKnowledgeSearch() -> Search {
        let search = Search(query: "Who is Sam Altman?")
        search.knowledge = Knowledge.sample()
        search.sources = [Source.sample()!, Source.sample()!, Source.sample()!]
        search.summary = getSampleSummary()
        
        return search
    }
    
    static func sampleImageSearch() -> Search {
        let search = Search(query: "Who is Sam Altman?")
        search.sources = [Source.sample()!, Source.sample()!, Source.sample()!]
        search.images = [Source.sample()!, Source.sample()!, Source.sample()!]
        search.summary = getSampleSummary()
        
        return search
    }
    
    static func samplePlaceSearch() -> Search {
        let search = Search(query: "Who is Sam Altman?")
        search.location = "San Francisco"
//        search.sources = [Source.sample()!, Source.sample()!, Source.sample()!]
        search.places = [Place.sample()!, Place.sample()!, Place.sample()!, Place.sample()!, Place.sample()!]
        search.summary = getSampleSummary()
        
        return search
    }
    
}
