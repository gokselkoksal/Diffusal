//
//  IllusionTests.swift
//  IllusionTests
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import XCTest
@testable import Illusion

class IllusionTests: XCTestCase {
    
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
