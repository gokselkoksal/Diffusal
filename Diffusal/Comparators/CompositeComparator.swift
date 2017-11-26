//
//  CompositeComparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public class CompositeComparator: Comparator {
    
    static let `default` = CompositeComparator(comparators: makeDefaultComparators())
    
    private var comparators: [AnyComparator]
    
    public init(comparators: [AnyComparator]) {
        self.comparators = comparators
    }
    
    public func compare(_ a: Any, _ b: Any) throws -> ComparatorResult {
        guard type(of: a) == type(of: b) else {
            throw ComparatorUnsupportedTypeError()
        }
        return try comparators.compare(a, b)
    }
}

public extension CompositeComparator {
    
    public static func makeDefaultComparators() -> [AnyComparator] {
        let valueComparators: [AnyComparator] = [
            EquatableComparator()
        ]
        
        let collectionComparators: [AnyComparator] = [
            ArrayComparator(valueComparators: valueComparators),
            DictionaryComparator(valueComparators: valueComparators)
        ]
        
        let proxyComparator = ValueProxyComparator(
            valueComparators: valueComparators + collectionComparators
        )
        
        var comparators: [AnyComparator] = []
        comparators.append(contentsOf: valueComparators)
        comparators.append(contentsOf: collectionComparators)
        comparators.append(proxyComparator)
        
        return comparators
    }
}
