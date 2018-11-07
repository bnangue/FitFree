//
//  FavoriteRestaurant.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift
import CDYelpFusionKit

class FavoriteRestaurant: Object {

    @objc dynamic var id = "\(NSDate().timeIntervalSince1970)"
    @objc dynamic var restaurant: Restaurant?
   
    override static func primaryKey() -> String? {
        return "id"
    }
}
