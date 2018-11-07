//
//  FoodMenuItem.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift
class FoodMenuItem: Object {

    @objc dynamic var id = "\(NSDate().timeIntervalSince1970)"
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var itemDescription = ""
    @objc dynamic var price = ""
   
    override static func primaryKey() -> String? {
        return "id"
    }
}
