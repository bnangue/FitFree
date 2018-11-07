//
//  MenuPageRestaurantViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import CDYelpFusionKit
import RealmSwift
import Kingfisher

class MenuPageRestaurantViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    

    var restaurant: CDYelpBusiness!
    var restaurantId: String!
    var restaurantName: String!
    var images: [String] = []
    var foodMenuItemList: [FoodMenuItem] = []

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessAddressLabelText: UILabel!
    @IBOutlet weak var openInMapButton: UIButton!
    @IBOutlet weak var reviewCountLabelText: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var distanceLabelText: UILabel!
    @IBOutlet weak var isOpenLabelText: UILabel!
    @IBOutlet weak var priceClassLabelText: UILabel!
    @IBOutlet weak var linkToRestaurantHompageButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchRestaurant(id: restaurantId!)
        showActivityIndicator()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        self.title = restaurantName
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    func checkIfFoodMenuAvailable() {
        if foodMenuItemList.count > 0 {
            // hide button to open a WebView and show reataurant page

            linkToRestaurantHompageButton.isHidden = true
            linkToRestaurantHompageButton.isEnabled = false
        }else {
            // show button to open a WebView and show reataurant page
            linkToRestaurantHompageButton.isHidden = false
            linkToRestaurantHompageButton.isEnabled = true
        }
        
            
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodMenuItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableCell", for: indexPath) as! MenuItemTableViewCell
        
         cell.foodMenuItem = foodMenuItemList[indexPath.row]
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
        /*
         CDYelpFusionKitManager.shared.apiClient.fetchReviews(forBusinessId: id, locale: CDYelpLocale.german_germany) { (response) in
         if let response = response,  let reviews = response.reviews,
         reviews.count > 0 {
         print(String(describing: reviews.toJSON()))
         }
         }
         */
    }
    func populateViews(restaurant: CDYelpBusiness) {
       // businessname.text = restaurant.name
       // businessPrice.text = restaurant.price
        businessImageView.kf.setImage(with: restaurant.imageUrl)

        distanceLabelText.text = ""

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
    @IBAction func openMap(_ sender: Any) {
        //open Maps App amd show route
    }
    
    @IBAction func openRestaurantHomepage(_ sender: UIButton){
        //open WebView and show the restaurant HomePage
        let linkToPage = restaurant.url
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vC = storyBoard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        vC.urlToload = linkToPage
        vC.businessId = restaurant.id
        self.navigationController?.show(vC, sender: self)
    }
    

}
