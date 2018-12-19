//
//  SaveList.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 8/15/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import Foundation
import SwiftyJSON

class SaveList {
    var name: String
    var email: String
    var member: Bool
    var specialty: String
    var phone: String
    var notes: String
    
    init(name: String, email: String, member: Bool, specialty: String, phone: String, notes: String) {
        self.name = name
        self.email = email
        self.member = member
        self.specialty = specialty
        self.phone = phone
        self.notes = notes
    }
    
    func returnJSON() -> [String: Any] {
        return [
            "name": name as Any,
            "email":email as Any,
            "member": member as Any,
            "specialty": specialty as Any,
            "phone": phone as Any,
            "notes": notes as Any
        
        
        ]
    }
    
    
    
}



















