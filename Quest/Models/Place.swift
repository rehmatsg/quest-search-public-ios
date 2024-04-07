//
//  Place.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 25/03/24.
//

import Foundation

class Place: Identifiable {
    
    var id: String {
        self.url
    }
    
    let name: String
    let imageURL: String?
    let rating: Double
    let reviewCount: Int
    let categories: [String]?
    let longitude: Double
    let latitude: Double
    let displayPhoneNumber: String
    let phone: String
    let displayAddress: String
    let city: String?
    let url: String
    let isClosed: Bool

    init(name: String, imageURL: String?, rating: Double, reviewCount: Int, categories: [String]?, longitude: Double, latitude: Double, displayPhoneNumber: String, phone: String, displayAddress: String, city: String?, url: String, isClosed: Bool) {
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
        self.reviewCount = reviewCount
        self.categories = categories
        self.longitude = longitude
        self.latitude = latitude
        self.displayPhoneNumber = displayPhoneNumber
        self.phone = phone
        self.displayAddress = displayAddress
        self.city = city
        self.url = url
        self.isClosed = isClosed
    }
    
    static func fromDictionary(_ data: [String: Any?]) throws -> Place {
        let name = data["name"] as? String ?? "Unnamed Place"
        let imageURL = data["image_url"] as? String
        let rating = data["rating"] as? Double ?? 0.0
        let reviewCount = data["review_count"] as? Int ?? 0
        
        var categories: [String] = []
        if let categoriesMap = data["categories"] as? [[String: String]] {
            for value in categoriesMap {
                if let vs = value["title"] {
                    categories.append(vs)
                }
            }
        }
        
        let coordinates = data["coordinates"] as! [String: Any]
        let longitude = coordinates["longitude"] as! Double
        let latitude = coordinates["latitude"] as! Double
        
        let displayPhoneNumber = data["display_phone"] as! String
        let phone = data["phone"] as! String
        let locationDict = data["location"] as? [String: Any]
        let displayAddress = (locationDict?["display_address"] as? [String])?.joined(separator: ", ") ?? ""
        let city = (locationDict?["city"] as? [String])?.joined(separator: ", ") ?? ""
        let url = data["url"] as? String ?? ""
        let isClosed = data["is_closed"] as? Bool ?? true
        
        return Place(name: name, imageURL: imageURL, rating: rating, reviewCount: reviewCount, categories: categories, longitude: longitude, latitude: latitude, displayPhoneNumber: displayPhoneNumber, phone: phone, displayAddress: displayAddress, city: city, url: url, isClosed: isClosed)
    }
    
    static func sample() -> Place? {
        let data: [String: Any?] = [
            "name": "The Best Cafe",
            "image_url": "https://images.unsplash.com/photo-1567880905822-56f8e06fe630?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            "rating": 4.5,
            "review_count": 120,
            "coordinates": ["longitude": -122.470749, "latitude": 37.673431],
            "categories": [["title":"Cafe"], ["title":"Coffee"]],
            "display_phone": "+1 234-567-8900",
            "phone": "+12345678900",
            "location": ["display_address": ["123 Main St", "Unit A"]],
            "url": "http://example.com",
            "is_closed": true
        ]
        
        do {
            let place = try Place.fromDictionary(data)
            return place
        } catch {
            return nil
        }
    }
}
