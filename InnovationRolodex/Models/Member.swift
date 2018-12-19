//
//  Member.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 8/30/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import Foundation

struct Member: Codable {
    var id: Int?
    var name: String
    var email: String
    var member: Bool
    var specialty: String
    var phone: String
    var notes: String
}

extension Member {
    init(name: String, email: String, member: Bool, specialty: String, phone: String, notes: String) {
        self.name = name
        self.email = email
        self.member = member
        self.specialty = specialty
        self.phone = phone
        self.notes = notes
    }
}

