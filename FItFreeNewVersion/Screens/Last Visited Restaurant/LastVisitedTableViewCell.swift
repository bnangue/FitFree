//
//  LastVisitedTableViewCell.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import CDYelpFusionKit
import Kingfisher

class LastVisitedTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewName: UILabel!
    @IBOutlet weak var reviewDescription: UILabel!

    @IBOutlet weak var reviewImageView: UIImageView!

    
    var review: CDYelpReview! {
        didSet{
            reviewName.text = review.user?.name
            reviewDescription.text = review.text
            
           // reviewImageView.image = UIImage(named: review.user?.imageUrl)
             reviewImageView.kf.setImage(with: review.user?.imageUrl)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reviewImageView.image = nil
    }
    
    override func awakeFromNib() {
        reviewImageView.layer.cornerRadius = reviewImageView.frame.size.width / 2
        reviewImageView.clipsToBounds = true
        
        reviewName.preferredMaxLayoutWidth = reviewName.frame.size.width
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reviewName.preferredMaxLayoutWidth = reviewName.frame.size.width
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
