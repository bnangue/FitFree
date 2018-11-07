//
//  SecondViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var restaurants: [FavoriteRestaurant]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSideMenu()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
         tableView.tableFooterView = UIView(frame: .zero)
        
        loadData()
        tableView.reloadData()
    }

    func loadData() {
        let realm = try! Realm()
        restaurants = Array(realm.objects(FavoriteRestaurant.self))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if restaurants != nil {
            return restaurants.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessFavoriteCell", for: indexPath) as! BusinessCell
        let restaurant = restaurants[indexPath.row]
        cell.restaurantRealm = restaurant
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vC = storyBoard.instantiateViewController(withIdentifier: "MenuPageRestaurantViewController") as! MenuPageRestaurantViewController
        vC.restaurantId = restaurants?[indexPath.row].restaurant?.yelpId
        vC.restaurantName = restaurants?[indexPath.row].restaurant?.name
        self.navigationController?.show(vC, sender: self)
        // print(indexPath.row)
 
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

