//
//  JournalEntry.swift
//  Moodify
//
//  Created by Avi Khemani on 6/6/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import Foundation

struct JournalEntry: StoreableByName, Codable {
    
    var date: String
    var entry: String
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(date: String, entry: String) {
        self.date = date
        self.entry = entry
    }
    
    init?(json: Data) {
        if let decoded = try? JSONDecoder().decode(JournalEntry.self, from: json) {
            self = decoded
        } else {
            return nil
        }
    }
    
}

extension JournalEntry: PropertyListConvertible {
    
    var asPropertyList: Any? {
        return json
    }
    
    init?(fromPropertyList plist: Any) {
        if let json = plist as? Data {
            self.init(json: json)
        } else {
            return nil
        }
    }

    
}
