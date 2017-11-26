//
//  Array+Comparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 26.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

extension Array where Element == AnyComparator {
    
    func compare(_ a: Any, _ b: Any) throws -> ComparatorResult {
        for comparator in self {
            do {
                return try comparator._compare(a, b)
            } catch {
                continue // Try others.
            }
        }
        
        throw ComparatorUnsupportedTypeError()
    }
}
