//
//  Source.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 26/03/24.
//

import Foundation

// Source class to model the JSON data
class Source: Identifiable {
    
    var id: String {
        self.url
    }
    
    let url: String
    let title: String
    let hostname: String
    let description: String?
    let summary: String?
    let favicon: String?
    let thumbnail: String?

    init(url: String, title: String, hostname: String, description: String?, summary: String?, favicon: String?, thumbnail: String?) {
        self.url = url
        self.title = title
        self.hostname = hostname
        self.description = description
        self.summary = summary
        self.favicon = favicon
        self.thumbnail = thumbnail
    }
    
    static func fromDictionary(_ dict: [String: Any?]) throws -> Source {
        return Source(
            url: dict["url"] as! String,
            title: dict["title"] as! String,
            hostname: dict["hostname"] as! String,
            description: dict["description"] as? String,
            summary: dict["summary"] as? String,
            favicon: dict["favicon"] as? String,
            thumbnail: dict["thumbnail"] as? String
        )
    }
    
    static func sample() -> Source? {
        let data: [String: Any?] = [
            "url": "https://en.wikipedia.org/wiki/Sam_Altman",
            "result_type": "image",
            "title": "Sam Altman - Wikipedia",
            "hostname": "en.wikipedia.org",
            "description": "Samuel Harris Altman (/\\u02c8\\u0254\\u02d0ltm\\u0259n/; AWLT-m\\u0259n; born April 22, 1985) is an American entrepreneur and investor best known as the CEO of OpenAI since 2019 (he was briefly fired and reinstated in November 2023). Altman is considered to be one of the leading figures of the AI boom.",
            "summary": "Samuel Harris Altman is an American entrepreneur and investor best known as the CEO of OpenAI since 2019. Altman is considered to be one of the leading figures of the AI boom.",
            "favicon": "https://imgs.search.brave.com/0kxnVOiqv-faZvOJc7zpym4Zin1CTs1f1svfNZSzmfU/rs:fit:32:32:1/g:ce/aHR0cDovL2Zhdmlj/b25zLnNlYXJjaC5i/cmF2ZS5jb20vaWNv/bnMvNjQwNGZhZWY0/ZTQ1YWUzYzQ3MDUw/MmMzMGY3NTQ0ZjNj/NDUwMDk5ZTI3MWRk/NWYyNTM4N2UwOTE0/NTI3ZDQzNy9lbi53/aWtpcGVkaWEub3Jn/Lw",
            "thumbnail": "https://images.unsplash.com/photo-1711126056288-da66a36bed7f?q=80&w=2836&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        ]

        do {
            let source = try Source.fromDictionary(data)
            return source
        } catch {
            return nil
        }
    }
}
