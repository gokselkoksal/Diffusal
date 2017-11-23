//
//  EquatableComparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public class EquatableComparator<T: Equatable>: Comparator {
    
    public func compare(_ a: T, _ b: T) throws -> ComparatorResult {
        return a == b ? ComparatorResult.same : ComparatorResult.different(info: nil)
    }
}
