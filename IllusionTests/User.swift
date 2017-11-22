//
//  User.swift
//  IllusionTests
//
//  Created by Göksel Köksal on 22.11.2017.
//  Copyright © 2017 Goksel Koksal. All rights reserved.
//

import Foundation
@testable import Illusion

struct User {
    let username: String
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    let website: URL
}

extension User: Diffable {
    
    static var allKeyPaths: Set<PartialKeyPath<User>> {
        return [
            \User.username,
            \User.firstName,
            \User.lastName,
            \User.dateOfBirth,
            \User.website
        ]
    }
}
