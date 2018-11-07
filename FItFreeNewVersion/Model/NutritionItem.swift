//
//  NutritionItem.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import Foundation
import RealmSwift

class NutritionItem: Object {
    
    @objc dynamic var id = "\(NSDate().timeIntervalSince1970)"
    @objc dynamic var name = ""
    @objc dynamic var category = ""
    @objc dynamic var servingDescription = ""
    @objc dynamic var servingSize = ""
    @objc dynamic var servingUnit = ""
    @objc dynamic var calories = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
