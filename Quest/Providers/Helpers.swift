//
//  Helpers.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 28/03/24.
//

import Foundation

func jsonToDictionary(from jsonString: String) -> [String: Any]? {
    guard let jsonData = jsonString.data(using: .utf8) else {
        print("Error: Cannot convert string to Data")
        return nil
    }
    
    do {
        let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        return dictionary
    } catch {
        print("Error parsing JSON: \(error)")
        return nil
    }
}
