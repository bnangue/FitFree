//
//  RestaurantPresenter.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

class RestaurantPresenter: NSObject , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //handle the cell selction here
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeInsets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        return CGSize(width: collectionView.frame.width - edgeInsets.left - edgeInsets.right, height: 92.0)
    }
}
