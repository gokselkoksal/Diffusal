//
//  AnyEquatable.swift
//  Diffusal
//
//  Created by Göksel Köksal on 26.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public protocol AnyEquatable {
    func equals(to other: AnyEquatable) -> Bool
}

public extension AnyEquatable where Self: Equatable {
    func equals(to other: AnyEquatable) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

// MARK: Extensions

extension String: AnyEquatable { }
extension Float: AnyEquatable { }
extension Double: AnyEquatable { }
extension UInt: AnyEquatable { }
extension UInt8: AnyEquatable { }
extension UInt16: AnyEquatable { }
extension UInt32: AnyEquatable { }
extension UInt64: AnyEquatable { }
extension Int: AnyEquatable { }
extension Int8: AnyEquatable { }
extension Int16: AnyEquatable { }
extension Int32: AnyEquatable { }
extension Int64: AnyEquatable { }
extension URL: AnyEquatable { }
extension Data: AnyEquatable { }
extension Date: AnyEquatable { }

// TODO: Add more...
