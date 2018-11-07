//
//  RestaurantCollectionViewCell.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import CDYelpFusionKit
import Kingfisher

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabelRestaurant: UILabel!
    @IBOutlet weak var distanceLabelRestaurant: UILabel!
    
    @IBOutlet weak var imageRestaurantView: UIImageView!
    @IBOutlet weak var reviewLabelRestaurant: UILabel!
    @IBOutlet weak var priceLabelRestaurant: UILabel!
    
    @IBOutlet weak var reviewImageRestaurantView: UIImageView!
    @IBOutlet weak var addressLabelRestaurant: UILabel!
    @IBOutlet weak var categoriesLabelRestaurant: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageRestaurantView.image = nil
    }
    
    override func awakeFromNib() {
        imageRestaurantView.layer.cornerRadius = 4.0
        imageRestaurantView.clipsToBounds = true
    }
    func fill(with restaurant: CDYelpBusiness) {
        nameLabelRestaurant.text = restaurant.name
        distanceLabelRestaurant.text = String(format: "%.2f", restaurant.distance!) + " km"
        imageRestaurantView.kf.setImage(with: restaurant.imageUrl)
        reviewLabelRestaurant.text = "\(restaurant.reviewCount ?? 0)"
        priceLabelRestaurant.text = restaurant.price
        reviewImageRestaurantView.image = UIImage(named: "\(Int(restaurant.rating!))Stars")
        addressLabelRestaurant.text = String((restaurant.location?.displayAddress![0])! + ", " + (restaurant.location?.displayAddress![1])!)
        categoriesLabelRestaurant.text = restaurant.categories?[0].title
    }
}
