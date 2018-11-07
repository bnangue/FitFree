//
//  Interest.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

class Interest
{
    // MARK: - Public API
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    // MARK: - Private
    // dummy data
    static func fetchInterests() -> [Interest]
    {
        return [
            Interest(title: "Zuletzt besuchte Location Hops & Hominy am Do. 22.09.18", featuredImage: UIImage(named: "f1")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.7)),
            Interest(title: "Kaffee mit Freunden", featuredImage: UIImage(named: "f2")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.7)),
            Interest(title: "Restaurant in Frankurt", featuredImage: UIImage(named: "f3")!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.7)),
            Interest(title: "Exotisches Essen aus Morroco", featuredImage: UIImage(named: "f4")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.7)),
            
            Interest(title: "Reisen um die Welt", featuredImage: UIImage(named: "f5")!, color: UIColor(red: 245/255.0, green: 62/255.0, blue: 40/255.0, alpha: 0.7)),
            Interest(title: "Berlin Nachtleben", featuredImage: UIImage(named: "f6")!, color: UIColor(red: 103/255.0, green: 217/255.0, blue: 87/255.0, alpha: 0.7)),
            Interest(title: "USA - Californian Pizza", featuredImage: UIImage(named: "f7")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.7)),
            Interest(title: "\"All You Can Eat\" in deiner Nähe", featuredImage: UIImage(named: "f8")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.7)),
        ]
    }
}
