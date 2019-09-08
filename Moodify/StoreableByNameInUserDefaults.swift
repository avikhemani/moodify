//
//  StoreableByNameInUserDefaults.swift
//  EmojiArt
//
//  Created by Paul Hegarty on 5/13/19.
//  Copyright © 2019 CS193p Instructor. All rights reserved.
//

import Foundation

protocol PropertyListConvertible
{
    var asPropertyList: Any? { get }
    init?(fromPropertyList plist: Any)
}

// MARK: - Store a PropertyListConvertible by name in UserDefaults

extension StoreableByName where Self: PropertyListConvertible
{
    static private var rootKey: String { return "PropertyListConvertible.\(self)" }
    static private var allNamesKey: String { return "\(rootKey).allNames" }
    static private func key(for name: String?) -> String? {
        return name == nil ? nil : "\(rootKey).named.\(name!)"
    }
    
    static private(set) var names: Set<String> {
        get { return Set(UserDefaults.standard.array(forKey: allNamesKey) as? [String] ?? []) }
        set { UserDefaults.standard.set(Array(newValue), forKey: allNamesKey) }
    }
    
    init?(named name: String?) {
        if let key = Self.key(for: name), let plist = UserDefaults.standard.object(forKey: key) {
            self.init(fromPropertyList: plist)
        } else {
            return nil
        }
    }
    
    func save(as name: String?) {
        if let key = Self.key(for: name) {
            UserDefaults.standard.set(self.asPropertyList, forKey: key)
            Self.names.insert(name!)
        }
    }
    
    static func delete(named name: String?) {
        if let key = Self.key(for: name) {
            UserDefaults.standard.set(nil, forKey: key)
            Self.names.remove(name!)
        }
    }
}

