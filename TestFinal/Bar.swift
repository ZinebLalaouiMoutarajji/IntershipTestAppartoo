//
//  Bar.swift
//  TestFinal
//
//  Created by vPro on 26/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import Foundation
class Bar {
    var nom: String
    var type: String
    var location: String
    
    init(nom: String, type: String, location: String ) {
        self.nom = nom
        self.type = type
        self.location = location
    }
    convenience init() {
        self.init(nom: "", type: "", location: "")
    }
}
