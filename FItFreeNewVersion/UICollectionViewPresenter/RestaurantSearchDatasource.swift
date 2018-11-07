//
//  RestaurantSearchDatasource.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

class RestaurantSearchDatasource: NSObject , UICollectionViewDataSource {
    
    var objects: [Restaurant] = []
    
    func fill() {
        objects = [Restaurant(title: "Linder Hotel Restautant", address: "60431 Berkersheimergasse 30", image: UIImage(named: "1")!),
                   Restaurant(title: "La Palma", address: "60431 Berkersheimergasse 30", image: UIImage(named: "2")!),
                   Restaurant(title: "Zum Grill Dreieich", address: "60431 Berkersheimergasse 30", image: UIImage(named: "3")!),
                   Restaurant(title: "Joe's Burger", address: "60431 Berkersheimergasse 30", image: UIImage(named: "2")!),
                   Restaurant(title: "Döner Heman", address: "60431 Berkersheimergasse 30", image: UIImage(named: "1")!),
                   Restaurant(title: "Pizza Ristaurante", address: "60431 Berkersheimergasse 30", image: UIImage(named: "3")!),
                   Restaurant(title: "Burger King", address: "60431 Berkersheimergasse 30", image: UIImage(named: "1")!),
                   Restaurant(title: "Boat Restaurant", address: "60431 Berkersheimergasse 30", image: UIImage(named: "3")!),
                   Restaurant(title: "Italian Love", address: "60431 Berkersheimergasse 30", image: UIImage(named: "1")!)]
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSearchRestarant", for: indexPath) as! RestaurantCollectionViewCell
        let restaurant = objects[indexPath.item]
       // cell.fill(with: restaurant)
        return cell
    }
    
}

