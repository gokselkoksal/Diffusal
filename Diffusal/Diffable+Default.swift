//
//  Diffable+Default.swift
//  Diffusal
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public extension Diffable {
    
    public static var comparator: AnyComparator {
        return CompositeComparator.default
    }
    
    public static func diff(_ a: Self, _ b: Self) throws -> Diff<Self> {
        var changes: Set<KeyPathChange<Self>> = []
        
        for keyPath in allKeyPaths {
            let value1 = a[keyPath: keyPath]
            let value2 = b[keyPath: keyPath]
            
            do {
                let result = try comparator._compare(value1, value2)
                
                switch result {
                case .same:
                    break // All good!
                case .different(info: let info):
                    let change = KeyPathChange(keyPath: keyPath, info: info)
                    changes.insert(change)
                }
            } catch {
                throw DiffableUnsupportedTypeError(keyPath: keyPath)
            }
        }
        
        return Diff(changes: changes)
    }
}
