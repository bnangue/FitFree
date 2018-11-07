//
//  RestaurantDetailsViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 29.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController, UICollectionViewDataSource {
    
    var restaurant: CDYelpBusiness!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var businessname: UILabel!
    @IBOutlet weak var businessPrice: UILabel!
    @IBOutlet weak var openingHour: UILabel!
    @IBOutlet weak var ImageViewrRatings: UIImageView!
    
    var images: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        //fetchRestaurant(id: restaurant.id!)
        // Do any additional setup after loading the view.
       // pageControll.numberOfPages = images.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /*
    func fetchRestaurant(id: String) {
       
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: id, locale: CDYelpLocale.german_germany) { (business) in
            if let restaurant = business {
                print(String(describing: restaurant.toJSON()))
                self.images = restaurant.photos!
                self.collectionView.reloadData()
                self.populateViews(restaurant: restaurant)
            }
        }
     
        CDYelpFusionKitManager.shared.apiClient.fetchReviews(forBusinessId: id, locale: CDYelpLocale.german_germany) { (response) in
            if let response = response,  let reviews = response.reviews,
                reviews.count > 0 {
                print(String(describing: reviews.toJSON()))
            }
        }
         
 
    }
  */
    func populateViews(restaurant: CDYelpBusiness) {
        businessname.text = restaurant.name
        businessPrice.text = restaurant.price
        openingHour.text = ""
        ImageViewrRatings.image = UIImage(named: "\(String(format: "%.0f", restaurant.rating!))Stars")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantDetailCell", for: indexPath) as! RestaurantDetailsCollectionViewCell
    
       // cell.imageViewRestaurantDetailsCell.kf.setImage(with: URL(string: images[indexPath.item]))
        
        return cell
    }
    
    
   
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RestaurantDetailsViewController: UICollectionViewDelegate {
    
}
