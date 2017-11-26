//
//  DiffusalTests.swift
//  DiffusalTests
//
//  Created by Göksel Köksal on 23.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import XCTest
@testable import Diffusal

class DiffusalTests: XCTestCase {
    
    func testCollections() throws {
        
        struct Data: Diffable {
            var array: [String]
            var dictionary: [Int: String]
            
            static let allKeyPaths: Set<PartialKeyPath<Data>> = [\Data.array, \Data.dictionary]
        }
        
        let data1 = Data(array: ["Goksel", "Sila"], dictionary: [0: "Goksel", 1: "Sila"])
        var data2 = data1
        data2.array.append("New")
        var data3 = data1
        data3.dictionary[2] = "New"
        
        let diff1 = try Data.diff(data1, data2)
        XCTAssertNotNil(diff1.change(for: \Data.array))
        XCTAssertNil(diff1.change(for: \Data.dictionary))
        
        let diff2 = try Data.diff(data1, data3)
        XCTAssertNil(diff2.change(for: \Data.array))
        XCTAssertNotNil(diff2.change(for: \Data.dictionary))
    }
    
    func testProxy() throws {
        struct Customer: Diffable {
            static var allKeyPaths: Set<PartialKeyPath<Customer>> = [\Customer.orders]
            var orders: ArrayProxy<String> = ArrayProxy([])
        }
        
        var customer = Customer()
        customer.orders.execute(
            [.append("Order1"), .append("Order2")]
        )
        let c1 = customer
        customer.orders.execute(
            .insert([.init(index: 0, element: "OrderX1"), .init(index: 1, element: "OrderX2")])
        )
        let c2 = customer
        
        let diff = try Customer.diff(c1, c2)
        let change = diff.change(for: \Customer.orders)
        
        if let requests = change?.info as? [CollectionRequest<String>] {
            XCTAssertEqual(requests.count, 1)
            XCTAssertTrue(requests[0].isInsert(at: IndexSet([0, 1])))
        }
    }
    
    func testSimpleDiff() throws {
        let dob1 = Date()
        let dob2 = dob1.addingTimeInterval(5)
        let url = URL(string: "https://www.google.com")!
        
        let user1 = User(
            username: "gokselkk",
            firstName: "Goksel",
            lastName: "Koksal",
            dateOfBirth: dob1,
            website: url
        )
        
        let user2 = User(
            username: "baketheegg",
            firstName: "Sila",
            lastName: "Koksal",
            dateOfBirth: dob2,
            website: url
        )
        
        let diff = try User.diff(user1, user2)
        
        XCTAssertEqual(diff.changes.count, 3)
        XCTAssertNotNil(diff.change(for: \User.username))
        XCTAssertNotNil(diff.change(for: \User.firstName))
        XCTAssertNotNil(diff.change(for: \User.dateOfBirth))
    }
}
