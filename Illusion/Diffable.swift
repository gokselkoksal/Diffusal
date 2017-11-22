//
//  Diffable.swift
//  Illusion
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public protocol Diffable {
    // TODO: Try to dynamically get key-paths.
    static var allKeyPaths: Set<PartialKeyPath<Self>> { get }
    static var comparator: AnyComparator { get }
    static func diff(_ a: Self, _ b: Self) throws -> Diff<Self>
}

public struct Diff<Object> {
    
    public let changes: Set<KeyPathChange<Object>>
    
    public func change(for keyPath: PartialKeyPath<Object>) -> KeyPathChange<Object>? {
        return changes.first(where: { $0.keyPath == keyPath })
    }
}

public struct KeyPathChange<Object> {
    public let keyPath: PartialKeyPath<Object>
    public let info: Any?
}

extension KeyPathChange: Hashable {
    
    public var hashValue: Int {
        return keyPath.hashValue
    }
    
    public static func ==(a: KeyPathChange<Object>, b: KeyPathChange<Object>) -> Bool {
        return a.hashValue == b.hashValue
    }
}
