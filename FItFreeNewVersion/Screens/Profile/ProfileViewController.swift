//
//  ProfileViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import SideMenu
class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         setupSideMenu()
        self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.size.width / 2
        self.profilePictureImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func setupSideMenu() {
        
        let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        
        // Set up a cool background image for demo purposes
        // SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }

}
