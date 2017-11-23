//
//  Comparator.swift
//  Diffusal
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public enum ComparatorResult {
    case same
    case different(info: Any?)
}

public protocol AnyComparator {
    func _compare(_ a: Any, _ b: Any) throws -> ComparatorResult
}

public protocol Comparator: AnyComparator {
    associatedtype Value
    func compare(_ a: Value, _ b: Value) throws -> ComparatorResult
}

extension Comparator {
    public func _compare(_ a: Any, _ b: Any) throws -> ComparatorResult {
        guard let a = a as? Value, let b = b as? Value else {
            throw ComparatorUnsupportedTypeError()
        }
        return try compare(a, b)
    }
}
