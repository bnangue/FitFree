//
//  PlaceSearchViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 23.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PlaceSearchViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var searchBarItem: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableview: UITableView!
    
    var locationManager = CLLocationManager()
    
    @IBAction func displayCurrentLocation(_ sender: Any) {
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted ||
            CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined{
                
                locationManager.requestWhenInUseAuthorization()
            }
           // locationManager.desiredAccuracy = 1.0
            //locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func showCurrentLocation(_ sender: Any) {
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted ||
                CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined{
                
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.startUpdatingLocation()
           
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBarItem.delegate = self
        tableview.dataSource = self
        tableview.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //use kCLLocationAccuracyHundredMeters to conserve battery life
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Ignoring User
        UIApplication.shared.beginIgnoringInteractionEvents()
         locationManager.stopUpdatingLocation()
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        // Searchbar hide
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create search request
        let searchRequest = MKLocalSearchRequest()
        
        searchRequest.naturalLanguageQuery = searchBar.text
        // create Actual search
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("Error")
            }
            else
            {
                //remove annotation
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //get the data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                // create annotation
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
  

}
extension PlaceSearchViewController: CLLocationManagerDelegate {
    
    
    //MARK:- CLLocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        self.mapView.setRegion(region, animated: true)
        
        if let location = locations.first {
            print("location \(location)")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
extension PlaceSearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchLocationCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}
extension PlaceSearchViewController: UITableViewDelegate{
    
}
