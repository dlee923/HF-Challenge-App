//
//  User.swift
//  HF Test
//
//  Created by Daniel Lee on 5/9/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import Foundation

class User: NSObject {
    
    // MARK: - Properties
    var email: String?
    var latlng: String?
    var name: String?
    
    // MARK: - Initialization
    override init() {
        super.init()
    }
    
    init(email: String, latlng: String, name: String) {
        super.init()
        self.email = email
        self.latlng = latlng
        self.name = name
    }
    
}
