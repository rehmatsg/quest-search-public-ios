//
//  Item.swift
//  Quest
//
//  Created by Rehmat Singh Gill on 24/03/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
