//
//  BounceImageView.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

class BounceImageView: UIImageView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        UIImageView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity:6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        super.touchesBegan(touches, with: event)
        
    }

}
