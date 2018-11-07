//
//  FIndRestaurantViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.10.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import CDYelpFusionKit


protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class FIndRestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var locationManager = CLLocationManager()
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    var coordinates: CLLocationCoordinate2D? = nil
    var restaurants: [CDYelpBusiness]!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func filtertableView(_ sender: UISegmentedControl){
        
        let getIndex = segmentedController.selectedSegmentIndex
      
        switch (getIndex)
        {
            
        case 1:
            //filter sort by distance
          searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.distance, priceTiers: nil, openNow: true, openAt: nil)
            
        case 2:
            //filter sort by rating
            
            searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.reviewCount, priceTiers: nil, openNow: true, openAt: nil)
        case 3:
            //filter sort by preis
            
            searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.bestMatch, priceTiers: [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns], openNow: true, openAt: nil)
        default:
           searchRestaurantDefault(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //use kCLLocationAccuracyHundredMeters to conserve battery life
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        showActivityIndicator()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Suchen"
        navigationItem.titleView = resultSearchController?.searchBar
        
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
         tableView.tableFooterView = UIView(frame: .zero)
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        let restaurant = restaurants[indexPath.row]
        cell.restaurant = restaurant
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
 
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         let vC = storyBoard.instantiateViewController(withIdentifier: "MenuPageRestaurantViewController") as! MenuPageRestaurantViewController
         vC.restaurantId = restaurants?[indexPath.row].id
         vC.restaurantName = restaurants?[indexPath.row].name
         self.navigationController?.show(vC, sender: self)
 
       // print(indexPath.row)
        /*
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vC = storyBoard.instantiateViewController(withIdentifier: "LastVisitedRestaurantViewController") as! LastVisitedRestaurantViewController
        vC.restaurant = restaurants?[indexPath.row]
        self.navigationController?.show(vC, sender: self)
         */
        //to use later 
    }
    
    
    
    func searchRestaurantDefault(latitude: Double, longitude: Double) {
        
        // Cancel any API requests previously made
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        // Query Yelp Fusion API for business results
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: "food",
                                                                 location: nil,
                                                                 latitude: latitude,
                                                                 longitude: longitude,
                                                                 radius: nil,
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
                                                                        self.stopActivityIndicator()
                                                                        //print("\(self.restaurants.count) after init tableview")
                                                                         //print("\(String(describing: businesses[0].toJSON()))")
                                                                        //for business in businesses {
                                                                        //   print("\(String(describing: business.toJSON()))")
                                                                        //}
                                                                        
                                                                    }else {
                                                                        self.stopActivityIndicator()
                                                                    }
        }
    }
    
    
    func searchRestaurantFiltered(latitude: Double, longitude: Double, sortBy: CDYelpBusinessSortType?, priceTiers: [CDYelpPriceTier]?, openNow: Bool?, openAt: Int?) {
        // Cancel any API requests previously made
       
        CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
        // Query Yelp Fusion API for business results
        // list of categories [.activeLife, .food, .restaurants, .foodDeliveryServices, .foodTrucks, .fastFood, .pizza, .sushiBars]
        CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: "food",
                                                                 location: nil,
                                                                 latitude: latitude,
                                                                 longitude: longitude,
                                                                 radius: nil,
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
                                                                        self.stopActivityIndicator()
                                                                        // print("\(self.restaurants.count) tableview")
                                                                        // print("\(String(describing: businesses[0].toJSON()))")
                                                                        //for business in businesses {
                                                                        //   print("\(String(describing: business.toJSON()))")
                                                                        //}
                                                                        
                                                                    }else {
                                                                        self.stopActivityIndicator()
                                                                    }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
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
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHomeViewController", sender: self)
    }
    
}
extension FIndRestaurantViewController: CLLocationManagerDelegate {
    
    
    //MARK:- CLLocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        // self.mapView.setRegion(region, animated: true)
        if let location = locations.first {
            coordinates = location.coordinate
            searchRestaurantDefault(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let regionLocation = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(regionLocation, animated: true)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

extension FIndRestaurantViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
         showActivityIndicator()
        selectedPin = placemark
        coordinates = placemark.coordinate
        // clear existing pins
     
        searchRestaurantDefault(latitude: (selectedPin?.coordinate.latitude)!, longitude: (selectedPin?.coordinate.longitude)!)

        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion.init(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
         print("pin recieved")
        
        
    }
}

extension FIndRestaurantViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
}

    




