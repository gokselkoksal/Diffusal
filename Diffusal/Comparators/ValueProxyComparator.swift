//
//  ValueProxyComparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 26.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public class ValueProxyComparator: Comparator {
    
    private let valueComparators: [AnyComparator]
    
    public init(valueComparators: [AnyComparator]) {
        self.valueComparators = valueComparators
    }
    
    public func compare(_ a: AnyValueProxy, _ b: AnyValueProxy) throws -> ComparatorResult {
        let result = try valueComparators.compare(a._value, b._value)
        
        switch result {
        case .same:
            return .same
        case .different(info: _): // Replace info if proxy.
            return .different(info: b._changelog)
        }
    }
}
