//
//  LastVisitedRestaurantViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 25.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import RealmSwift
import CDYelpFusionKit
import Kingfisher

class LastVisitedRestaurantViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessAddressLabelText: UILabel!
     @IBOutlet weak var reviewCountLabelText: UILabel!
     @IBOutlet weak var ratingsImageView: UIImageView!
     @IBOutlet weak var isOpenLabelText: UILabel!
     @IBOutlet weak var priceClassLabelText: UILabel!
     @IBOutlet weak var lastvisitedDataLabelText: UILabel!
     @IBOutlet weak var reviewstitleLabelText: UILabel!
    @IBOutlet weak var goToMenuLabelText: UILabel!
    
     @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    
     @IBOutlet weak var tableView: UITableView!
    
    var restaurant: CDYelpBusiness!
     var restaurantLastVisited: LastVisitedLocation!
    var images: [String] = []
    var reviewList: [CDYelpReview] = []
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        self.title = restaurantLastVisited.name
        self.navigationItem.largeTitleDisplayMode = .always
        //fetchRestaurant(id: restaurant.id!)
        fetchRestaurant(id: restaurantLastVisited.yelpId)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ReviewTableCell", for: indexPath) as! LastVisitedTableViewCell
        //create var review in MenuItemTableViewCell
        cell.review = reviewList[indexPath.row]
        return cell
    }
    
    func showActivityIndicator(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func stopActivityIndicator(){
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }

    func fetchRestaurant(id: String) {
        
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: id, locale: CDYelpLocale.german_germany) { (business) in
            if let restaurant = business {
                //print(String(describing: restaurant.toJSON()))
                self.restaurant = restaurant
                self.images = restaurant.photos!
                self.stopActivityIndicator()
                self.populateViews(restaurant: restaurant)
            }
        }
        
        
         CDYelpFusionKitManager.shared.apiClient.fetchReviews(forBusinessId: id, locale: CDYelpLocale.german_germany) { (response) in
         if let response = response,  let reviews = response.reviews,
         reviews.count > 0 {
            
         print(String(describing: reviews.toJSON()))
            //populate table
            self.reviewList = reviews
            self.tableView.reloadData()
            }
         }
        if reviewList.count == 0 {
            reviewstitleLabelText.text = "Keine Reviews"
        }
 
    }
    func populateViews(restaurant: CDYelpBusiness) {
        
        businessImageView.kf.setImage(with: restaurant.imageUrl)
        
        lastvisitedDataLabelText.text = "Zuletzt besucht am " + restaurantLastVisited.date
        businessAddressLabelText.text = restaurant.location?.displayAddress?.joined(separator: ",")
        reviewCountLabelText.text = "\(restaurant.reviewCount ?? 0) Review(s)"
        priceClassLabelText.text = restaurant.price
        if restaurant.isClosed == true {
            isOpenLabelText.text = "geöffnet"
            isOpenLabelText.textColor = UIColor.green
        }else {
            isOpenLabelText.text = "geschlossen"
            isOpenLabelText.textColor = UIColor.red
        }
        ratingsImageView.image = UIImage(named: "\(String(format: "%.0f", restaurant.rating!))Stars")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func callPressed(_ sender: UIButton){
        
        
    }
    @IBAction func directionPressed(_ sender: UIButton){
        
        
    }
    @IBAction func webPressed(_ sender: UIButton){
        //open WebView and show the restaurant HomePage
        let linkToPage = restaurant.url
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vC = storyBoard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        vC.urlToload = linkToPage
        vC.businessId = restaurant.id
        self.navigationController?.show(vC, sender: self)
        
    }
}
