//
//  StoreableByName.swift
//  EmojiArt
//
//  Created by Paul Hegarty on 5/13/19.
//  Copyright © 2019 CS193p Instructor. All rights reserved.
//

import Foundation

protocol StoreableByName {
    static var names: Set<String> { get }
    init?(named name: String?)
    func save(as name: String?)
    static func delete(named name: String?)
}
