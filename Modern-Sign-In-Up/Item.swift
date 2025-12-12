//
//  Item.swift
//  Modern-Sign-In-Up
//
//  Created by Mohamad Shehab on 12/12/2025.
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
