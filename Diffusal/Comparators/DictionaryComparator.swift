//
//  DictionaryComparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 26.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public struct DictionaryComparatorInfo<Key> {
    public let key: Key
    public let elementInfo: Any?
}

public class DictionaryComparator: Comparator {
    
    private let valueComparators: [AnyComparator]
    
    public init(valueComparators: [AnyComparator]) {
        self.valueComparators = valueComparators
    }
    
    public func compare(_ a: [AnyHashable: Any], _ b: [AnyHashable: Any]) throws -> ComparatorResult {
        let keys1 = a.keys
        var keys2 = Set(b.keys)
        
        for key in keys1 {
            if keys2.remove(key) == nil {
                // Key does not exist.
                let info = DictionaryComparatorInfo(key: key, elementInfo: nil)
                return ComparatorResult.different(info: info)
            }
            
            if let value1 = a[key], let value2 = b[key] {
                let result = try valueComparators.compare(value1, value2)
                
                switch result {
                case .same:
                    continue
                case .different(info: let info):
                    let info = DictionaryComparatorInfo(key: key, elementInfo: info)
                    return ComparatorResult.different(info: info)
                }
            } else {
                let info = DictionaryComparatorInfo(key: key, elementInfo: nil)
                return ComparatorResult.different(info: info)
            }
        }
        
        return keys2.count == 0 ? ComparatorResult.same : ComparatorResult.different(info: nil)
    }
}
