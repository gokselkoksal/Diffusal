//
//  CollectionRequest.swift
//  Diffusal
//
//  Created by Göksel Köksal on 26.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation

public enum CollectionRequest<Element> {
    
    public struct Row {
        
        public let index: Int
        public let element: Element
        
        public init(index: Int, element: Element) {
            self.index = index
            self.element = element
        }
    }
    
    case reload([Element])
    case append(Element)
    case insert([Row])
    case remove(indexes: IndexSet)
    case replace(range: Range<Int>, elements: [Element])
}

// MARK: Helpers

public extension CollectionRequest {
    
    public func isReload() -> Bool {
        switch self {
        case .reload(_):
            return true
        default:
            return false
        }
    }
    
    public func isAppend() -> Bool {
        switch self {
        case .append(_):
            return true
        default:
            return false
        }
    }
    
    public func isRemove(from indexes: IndexSet) -> Bool {
        switch self {
        case .remove(indexes: let removalIndexes):
            return indexes == removalIndexes
        default:
            return false
        }
    }
    
    public func isInsert(at indexes: IndexSet) -> Bool {
        switch self {
        case .insert(let rows):
            let insertionIndexes = IndexSet(rows.map({ $0.index }))
            return indexes == insertionIndexes
        default:
            return false
        }
    }
    
    public func isReplace(in range: Range<Int>) -> Bool {
        switch self {
        case .replace(range: let replaceRange, elements: _):
            return range == replaceRange
        default:
            return false
        }
    }
}
