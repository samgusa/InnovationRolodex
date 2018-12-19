//
//  Realmed.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 7/29/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import Foundation
import RealmSwift

class Realmed: Object {
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var member = false
    @objc dynamic var speciality = ""
    @objc dynamic var phone = ""
    @objc dynamic var notes = ""
    
    override static func primaryKey() -> String {
        return "name"
    }
}
