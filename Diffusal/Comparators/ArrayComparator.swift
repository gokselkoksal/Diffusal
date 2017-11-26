//
//  ArrayComparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 24.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public struct ArrayComparatorInfo {
    public let index: Int
    public let elementInfo: Any?
}

public class ArrayComparator: Comparator {
    
    private let valueComparators: [AnyComparator]
    
    public init(valueComparators: [AnyComparator]) {
        self.valueComparators = valueComparators
    }
    
    public func compare(_ a: [Any], _ b: [Any]) throws -> ComparatorResult {
        guard a.count == b.count else {
            return .different(info: nil)
        }
        
        for (index, (valueA, valueB)) in zip(a, b).enumerated() {
            switch try valueComparators.compare(valueA, valueB) {
            case .same:
                continue
            case .different(info: let info):
                let aggregateInfo = ArrayComparatorInfo(
                    index: index,
                    elementInfo: info
                )
                return .different(info: aggregateInfo)
            }
        }
        
        return .same
    }
}
