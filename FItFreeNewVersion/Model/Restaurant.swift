//
//  Restaurant.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import Foundation
import RealmSwift

class Restaurant: Object {
    
    @objc dynamic var id = "\(NSDate().timeIntervalSince1970)"
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var itemDescription = ""
    @objc dynamic var price = ""
    @objc dynamic var yelpId = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var reviewCount = 0
    @objc dynamic var address = ""
    @objc dynamic var pictures = ""
    @objc dynamic var reviews = ""
    @objc dynamic var categories = ""
    @objc dynamic var isClosed = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
