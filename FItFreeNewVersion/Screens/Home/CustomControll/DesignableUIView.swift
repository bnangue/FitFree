//
//  DesignableUIView.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

@IBDesignable class DesignableUIView: BounceView{
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear  {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
