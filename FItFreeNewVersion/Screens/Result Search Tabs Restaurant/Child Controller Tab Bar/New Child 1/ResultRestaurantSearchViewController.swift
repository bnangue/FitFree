//
//  ResultRestaurantSearchViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 28.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import CDYelpFusionKit
import XLPagerTabStrip
import MapKit



class ResultRestaurantSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider{

    @IBOutlet weak var tableView: UITableView!
    var restaurants: [CDYelpBusiness]!
    var selectedPin: MKPlacemark? = nil

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        //searchTest(latitude: 50.102482, longitude: 8.547457)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "List")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if restaurants != nil {
            return restaurants.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        let restaurant = restaurants[indexPath.row]
        cell.restaurant = restaurant
        
        return cell
    }
    
    
    
    
    
    func searchRestaurantDefault(latitude: Double, longitude: Double) {
        // Cancel any API requests previously made
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        // Query Yelp Fusion API for business results
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: "Essen",
                                                                 location: nil,
                                                                 latitude: latitude,
                                                                 longitude: longitude,
                                                                 radius: 10000,
                                                                 categories: nil,
                                                                 locale: .german_germany,
                                                                 limit: 40,
                                                                 offset: nil,
                                                                 sortBy: .bestMatch,
                                                                 priceTiers: nil,
                                                                 openNow: true,
                                                                 openAt: nil,
                                                                 attributes: nil) { (response) in
                                                                    
                                                                    if let response = response,
                                                                        let businesses = response.businesses,
                                                                        businesses.count > 0 {
                                                                        self.restaurants = businesses
                                                                        self.tableView.reloadData()
                                                                        //print("\(self.restaurants.count) after init tableview")
                                                                        // print("\(String(describing: businesses[0].toJSON()))")
                                                                        //for business in businesses {
                                                                        //   print("\(String(describing: business.toJSON()))")
                                                                        //}
                                                                        
                                                                    }
        }
    }

   
    func searchRestaurantFiltered(latitude: Double, longitude: Double, sortBy: CDYelpBusinessSortType?, priceTiers: [CDYelpPriceTier]?, openNow: Bool?, openAt: Int?) {
        // Cancel any API requests previously made
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        // Query Yelp Fusion API for business results
        // list of categories [.activeLife, .food, .restaurants, .foodDeliveryServices, .foodTrucks, .fastFood, .pizza, .sushiBars]
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: "Essen",
                                                                 location: nil,
                                                                 latitude: latitude,
                                                                 longitude: longitude,
                                                                 radius: 10000,
                                                                 categories: nil,
                                                                 locale: .german_germany,
                                                                 limit: 40,
                                                                 offset: nil,
                                                                 sortBy: sortBy,
                                                                 priceTiers: priceTiers,
                                                                 openNow: openNow,
                                                                 openAt: openAt,
                                                                 attributes: nil) { (response) in
                                                                    
                                                                    if let response = response,
                                                                        let businesses = response.businesses,
                                                                        businesses.count > 0 {
                                                                        self.restaurants = businesses
                                                                        self.tableView.reloadData()
                                                                        // print("\(self.restaurants.count) tableview")
                                                                        // print("\(String(describing: businesses[0].toJSON()))")
                                                                        //for business in businesses {
                                                                        //   print("\(String(describing: business.toJSON()))")
                                                                        //}
                                                                        
                                                                    }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            
            let cell = sender as! UITableViewCell;
            let indexPath = tableView.indexPath(for: cell);
            let detailsVc = segue.destination as! RestaurantDetailsViewController;
            detailsVc.restaurant = restaurants[indexPath!.row];
        }
    }

}

