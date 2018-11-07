//
//  HomeExperienceHorizontalCollectionViewCell.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

class HomeExperienceHorizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollectionViewHoritalHome: UIImageView!
    @IBOutlet weak var labelCollectionViewHoritalHome: UILabel!
    @IBOutlet weak var uiViewCollectionViewHoritalHome: UIView!
    
    
    var interest: Interest? {
        didSet{
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        uiViewCollectionViewHoritalHome.layer.cornerRadius = 10.0
        imageCollectionViewHoritalHome.layer.cornerRadius = 10.0
        
        if let interest = interest {
            imageCollectionViewHoritalHome.image = interest.featuredImage
            labelCollectionViewHoritalHome.text = interest.title
            uiViewCollectionViewHoritalHome.backgroundColor = interest.color
        } else {
            imageCollectionViewHoritalHome.image = nil
            labelCollectionViewHoritalHome.text = nil
            uiViewCollectionViewHoritalHome.backgroundColor = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 3, height: 5)
        
        self.clipsToBounds = false
        
    }
}
