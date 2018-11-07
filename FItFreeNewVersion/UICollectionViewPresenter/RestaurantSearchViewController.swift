//
//  RestaurantSearchViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CDYelpFusionKit
import Kingfisher

class RestaurantSearchViewController: UIViewController {
    
    @IBOutlet weak var collectionViewRestaurantSearch: UICollectionView!

    var restaurantPresenter: RestaurantPresenter = RestaurantPresenter()
    var objects: [CDYelpBusiness] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setUp()
        searchTest()
        
        
    }
    
    func setUp(){
        collectionViewRestaurantSearch.dataSource = self
        collectionViewRestaurantSearch.delegate = restaurantPresenter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchTest() {
        // Cancel any API requests previously made
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        // Query Yelp Fusion API for business results
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: "Restaurant",
                                                                 location: nil,
                                                                 latitude: 50.102482,
                                                                 longitude: 8.547457,
                                                                 radius: 10000,
                                                                 categories: [.activeLife, .food],
                                                                 locale: .german_germany,
                                                                 limit: 40,
                                                                 offset: nil,
                                                                 sortBy: .rating,
                                                                 priceTiers: nil,
                                                                 openNow: true,
                                                                 openAt: nil,
                                                                 attributes: nil) { (response) in
                                                                    
                                                                    if let response = response,
                                                                        let businesses = response.businesses,
                                                                        businesses.count > 0 {
                                                                        self.objects = businesses
                                                                        self.collectionViewRestaurantSearch.reloadData()
                                                                        print("\(self.objects.count) after init")
                                                                       // print("\(String(describing: businesses[0].toJSON()))")
                                                                        //for business in businesses {
                                                                        //   print("\(String(describing: business.toJSON()))")
                                                                        //}
                                                                        
                                                                    }
        }
    }
}
extension RestaurantSearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(objects.count)")
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellSearchRestarant", for: indexPath) as! RestaurantCollectionViewCell
        let restaurant = objects[indexPath.item]
        cell.fill(with: restaurant)

      
        return cell
    }
}
