//
//  LastVisitedLocation.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import Foundation
import RealmSwift

class LastVisitedLocation: Object {
    
    @objc dynamic var id = "\(NSDate().timeIntervalSince1970)"
    @objc dynamic var name = ""
    @objc dynamic var date = ""
    @objc dynamic var yelpId = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
