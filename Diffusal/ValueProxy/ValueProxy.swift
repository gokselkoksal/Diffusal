//
//  ValueProxy.swift
//  Diffusal
//
//  Created by Göksel Köksal on 24.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public typealias ArrayProxy<Element> = ValueProxy<[Element], CollectionRequest<Element>>

public protocol AnyValueProxy {
    static var valueType: Any.Type { get }
    static var changeType: Any.Type { get }
    
    var _value: Any { get }
    var _changelog: Any { get }
}

public struct ValueProxy<Value, Change>: AnyValueProxy {
    
    public static var valueType: Any.Type { return Value.self }
    public static var changeType: Any.Type { return Change.self }
    
    public var _value: Any { return value }
    public var _changelog: Any { return changelog }
    
    public typealias WriteResult = (value: Value, change: Change)
    
    public private(set) var value: Value
    public private(set) var changelog: [Change] = []
    
    public init(_ value: Value) {
        self.value = value
    }
    
    public mutating func write(_ block: (_ value: Value) -> WriteResult) {
        let result = block(value)
        
        self.value = result.value
        self.changelog.append(result.change)
    }
}

public extension ValueProxy where Value: RangeReplaceableCollection, Value.Index == Int, Change == CollectionRequest<Value.Element> {
    
    public mutating func execute(_ collectionRequests: [CollectionRequest<Value.Element>]) {
        for collectionRequest in collectionRequests {
            switch collectionRequest {
            case .append(let element):
                value.append(element)
            case .insert(let rows):
                for row in rows {
                    value.insert(row.element, at: row.index)
                }
            case .remove(indexes: let indexes):
                for index in indexes {
                    value.remove(at: index)
                }
            case .replace(range: let range, elements: let elements):
                value.replaceSubrange(range, with: elements)
            case .reload(let elements):
                let range = value.startIndex..<value.endIndex
                value.replaceSubrange(range, with: elements)
            }
        }
        
        changelog = collectionRequests
    }
    
    public mutating func execute(_ collectionRequest: CollectionRequest<Value.Element>) {
        execute([collectionRequest])
    }
}
