//
//  Article.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 01/04/24.
//

import Foundation

class Article: Identifiable {
    
    var id: String
    var thread_id: String?
    
    let url: String
    let topic: String
    let title: String
    let description: String?
    let summary: String?
    let thumbnail: String
    let favicon: String?
    let hostname: String
    let sitename: String?
    let publish_date: Date?

    init(id: String, thread_id: String?, url: String, topic: String, title: String, description: String?, summary: String?, thumbnail: String, favicon: String?, hostname: String, sitename: String?, publish_date: Int?) {
        self.id = id
        self.thread_id = thread_id
        self.url = url
        self.topic = topic
        self.title = title
        self.description = description
        self.summary = summary
        self.thumbnail = thumbnail
        self.favicon = favicon
        self.hostname = hostname
        self.sitename = sitename
        if publish_date != nil {
            self.publish_date = Date(timeIntervalSince1970: (Double(publish_date!) / 1000.0));
        } else {
            self.publish_date = nil
        }
    }
    
    static func fromDictionary(_ dict: [String: Any?]) throws -> Article {
        return Article(
            id: dict["id"] as! String,
            thread_id: dict["thread_id"] as? String,
            url: dict["url"] as! String,
            topic: dict["topic"] as! String,
            title: dict["title"] as! String,
            description: dict["description"] as? String,
            summary: dict["summary"] as? String,
            thumbnail: dict["thumbnail"] as! String,
            favicon: dict["favicon"] as? String,
            hostname: dict["hostname"] as! String,
            sitename: dict["sitename"] as? String,
            publish_date: dict["publish_date"] as? Int
        )
    }
    
    static func sample() -> Article? {
        let data: [String: Any?] = [
            "id": "1234",
            "thread_id": "12345",
            "url": "https://openai.com",
            "topic": "TECHNOLOGY",
            "title": "OpenAI releases Sora, text-to-video model",
            "description": "OpenAI on Monday released a breakthrough text-to-video model named Sora. Currently in testing phase, OpenAI expects to release the model to general public later this year.",
            "summary": "OpenAI on Monday released a breakthrough text-to-video model named Sora. Currently in testing phase, OpenAI expects to release the model to general public later this year.",
            "thumbnail": "https://images.unsplash.com/photo-1675557009317-bb59e35aba82?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            "favicon": "https://openai.com/favicon.ico",
            "hostname": "openai.com",
            "sitename": "OpenAI",
            "publish_date": 1702030587024
        ]

        do {
            let source = try Article.fromDictionary(data)
            return source
        } catch {
            return nil
        }
    }
    
}

extension Article {
    static func getFeed() async -> [String: [Article]] {
        guard let url = URL(string: "https://quest-search-production.up.railway.app/news/feed") else {
            print("Invalid URL")
            return [:]
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Attempt to parse the JSON data
            guard let jsonResult = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Failed to parse JSON into the expected format.")
                return [:]
            }
            
            // Process each category and its articles
            var topicsWithArticles = [String: [Article]]()
            if let feedData = jsonResult["news"] as? [String: [[String: Any]]] {
                for (topic, articlesData) in feedData {
                    var articles = [Article]()
                    for articleData in articlesData {
                        if let article = try? Article.fromDictionary(articleData) {
                            articles.append(article)
                        }
                    }
                    topicsWithArticles[topic] = articles
                }
            }
            
            return topicsWithArticles
        } catch {
            print("Error fetching data: \(error)")
            return [:]
        }
    }
}
