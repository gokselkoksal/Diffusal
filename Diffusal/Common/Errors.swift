//
//  Errors.swift
//  Diffusal
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public struct ComparatorUnsupportedTypeError: LocalizedError, CustomStringConvertible {
    
    public var localizedDescription: String {
        return "Comparator does not support given type."
    }
    
    public var description: String {
        return localizedDescription
    }
}

public struct DiffableUnsupportedTypeError: LocalizedError, CustomStringConvertible {
    
    public let rootType: Any.Type
    public let valueType: Any.Type
    public let keyPath: AnyKeyPath
    
    init(keyPath: AnyKeyPath) {
        self.keyPath = keyPath
        self.rootType = type(of: keyPath).rootType
        self.valueType = type(of: keyPath).valueType
    }
    
    public var localizedDescription: String {
        return "Cannot compare values of type \(valueType) in \(rootType)."
    }
    
    public var recoverySuggestion: String? {
        return "Provide a comparator that can compare \(valueType) values in \(rootType)."
    }
    
    public var description: String {
        return localizedDescription
    }
}
