//
//  CompositeComparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public class CompositeComparator: AnyComparator {
    
    static let `default` = CompositeComparator(comparators: makeDefaultComparators())
    
    private var comparators: [AnyComparator]
    
    public init(comparators: [AnyComparator]) {
        self.comparators = comparators
    }
    
    public func _compare(_ a: Any, _ b: Any) throws -> ComparatorResult {
        for comparator in comparators {
            do {
                return try comparator._compare(a, b)
            } catch {
                continue // Try others.
            }
        }
        
        throw ComparatorUnsupportedTypeError()
    }
}

public extension CompositeComparator {
    
    public static func makeDefaultComparators() -> [AnyComparator] {
        return [
            EquatableComparator<String>(),
            EquatableComparator<Int>(),
            EquatableComparator<UInt>(),
            EquatableComparator<Date>(),
            EquatableComparator<URL>(),
        ]
    }
}
