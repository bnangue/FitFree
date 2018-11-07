//
//  ActivitySport.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import Foundation
import  RealmSwift

class ActivitySport: Object {
    
    @objc dynamic var id = "\(NSDate().timeIntervalSince1970)"
    @objc dynamic var name = ""
    @objc dynamic var category = ""
    @objc dynamic var activityDescription = ""
    @objc dynamic var duration = ""
    @objc dynamic var calories = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
