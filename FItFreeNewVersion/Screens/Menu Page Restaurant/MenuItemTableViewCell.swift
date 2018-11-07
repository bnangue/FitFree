//
//  MenuItemTableViewCell.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import CDYelpFusionKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemName: UILabel!
    @IBOutlet weak var menuItemPrice: UILabel!
    @IBOutlet weak var menuItemDescription: UILabel!
    
    var foodMenuItem: FoodMenuItem! {
        didSet{
            menuItemName.text = foodMenuItem.name
            menuItemPrice.text = foodMenuItem.price
            menuItemDescription.text = foodMenuItem.itemDescription
            
            menuItemImageView.image = UIImage(named: foodMenuItem.image)
           // menuItemImageView.kf.setImage(with: menuItemImageView.imageUrl)

        }
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        menuItemImageView.image = nil
    }
    
    override func awakeFromNib() {
        menuItemImageView.layer.cornerRadius = 4.0
        menuItemImageView.clipsToBounds = true
        
        menuItemName.preferredMaxLayoutWidth = menuItemName.frame.size.width
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        menuItemName.preferredMaxLayoutWidth = menuItemName.frame.size.width
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


