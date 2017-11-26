//
//  EquatableComparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public class EquatableComparator: Comparator {
    public func compare(_ a: AnyEquatable, _ b: AnyEquatable) throws -> ComparatorResult {
        return a.equals(to: b) ? ComparatorResult.same : ComparatorResult.different(info: nil)
    }
}
