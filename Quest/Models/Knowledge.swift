//
//  Knowledge.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 25/03/24.
//

import Foundation

// MARK: - Knowledge
class Knowledge {
    let label, description, imageURL: String
    
    let website: String?
    
    let facebookURL: String?
    let twitterURL: String?
    let linkedinURL: String?
    let instagramURL: String?
    
    let attributes: [String: Any]

    init(label: String, description: String, imageURL: String, website: String?, facebookURL: String?, twitterURL: String?, linkedinURL: String?, instagramURL: String?, attributes: [String: Any]) {
        self.label = label
        self.description = description
        self.imageURL = imageURL
        self.website = website
        self.facebookURL = facebookURL
        self.twitterURL = twitterURL
        self.linkedinURL = linkedinURL
        self.instagramURL = instagramURL
        self.attributes = attributes
    }
    
    static func fromDictionary(_ dict: [String: Any?]) throws -> Knowledge {
        let socialLinksDict = dict["social_links"] as? [String: String] ?? [:]
        let attributes = dict["attributes"] as? [String: Any] ?? [:]

        return Knowledge(
            label: dict["label"] as? String ?? "",
            description: dict["description"] as? String ?? "",
            imageURL: dict["image"] as? String ?? "",
            website: dict["website"] as? String,
            facebookURL: socialLinksDict["facebook"],
            twitterURL: socialLinksDict["twitter"],
            linkedinURL: socialLinksDict["linkedin"],
            instagramURL: socialLinksDict["instagram"],
            attributes: attributes
        )
        
    }
    
    static func sample() -> Knowledge? {
        let data: [String: Any?] = [
            "image": "http://commons.wikimedia.org/wiki/Special:FilePath/Sam%20Altman%20CropEdit%20James%20Tamim.jpg",
            "website": "https://blog.samaltman.com/",
            "social_links": [
                "facebook": "https://www.facebook.com/samhaltman",
                "twitter": "https://twitter.com/sama"
            ],
            "attributes": [
                "Occupation": ["businessperson", "programmer", "blogger"],
                "Nationality": "United States of America",
                "Date of Birth": "1985-04-22T00:00:00Z",
                "Employer": ["Y Combinator", "Loopt", "OpenAI", "Reddit Inc."],
                "Educated at": ["Stanford University", "John Burroughs School"]
            ],
            "label": "Sam Altman",
            "description": "American venture-capitalist in Silicon Valley"
        ];

        do {
            let knowledge = try Knowledge.fromDictionary(data)
            return knowledge
        } catch {
            return nil
        }
        
    }
}
