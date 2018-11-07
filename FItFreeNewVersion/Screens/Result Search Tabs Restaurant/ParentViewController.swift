//
//  ParentViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation
import MapKit
import CDYelpFusionKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class ParentViewController: ButtonBarPagerTabStripViewController {

    let purpleInspireColor = UIColor(red:0, green:1.30, blue:0.63, alpha:1.0)
    var locationManager = CLLocationManager()
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    var coordinates: CLLocationCoordinate2D? = nil
    var restaurantSearchController: ResultRestaurantSearchViewController!
     var mapViewResultController: MapViewResultsViewController!

    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func filtertableView(_ sender: UISegmentedControl) {
        let getIndex = segmentedController.selectedSegmentIndex
        
        switch (getIndex)
        {
            
        case 1:
            //filter sort by distance
            if restaurantSearchController != nil && coordinates != nil {
                restaurantSearchController.searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.distance, priceTiers: nil, openNow: true, openAt: nil)
                
            }else {
                print("Controller is nil")
            }
            if mapViewResultController != nil && coordinates != nil{
                mapViewResultController.searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.distance, priceTiers: nil, openNow: true, openAt: nil)
            }
        
        case 2:
            //filter sort by rating
            
            if restaurantSearchController != nil && coordinates != nil {
                restaurantSearchController.searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.reviewCount, priceTiers: nil, openNow: true, openAt: nil)
                
            }else {
                print("Controller is nil")
            }
            if mapViewResultController != nil && coordinates != nil{
                mapViewResultController.searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.reviewCount, priceTiers: nil, openNow: true, openAt: nil)
            }
        case 3:
            //filter sort by preis
           
           if restaurantSearchController != nil && coordinates != nil {
            restaurantSearchController.searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.bestMatch, priceTiers: [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns], openNow: true, openAt: nil)
            
           }else {
            print("Controller is nil")
            }
           if mapViewResultController != nil && coordinates != nil{
                mapViewResultController.searchRestaurantFiltered(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!, sortBy: CDYelpBusinessSortType.bestMatch, priceTiers: [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns], openNow: true, openAt: nil)
            }
        default:
            // filter sort by default : best macht
            if restaurantSearchController != nil && coordinates != nil {
                restaurantSearchController.searchRestaurantDefault(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!)
            }else {
                print("Controller is nil")
            }
            if mapViewResultController != nil && coordinates != nil{
                mapViewResultController.searchRestaurantDefault(latitude: (coordinates?.latitude)!, longitude: (coordinates?.longitude)!)

            }
        }
        
    }
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor(named: "buttonBarBackgroundColor")!
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor(named: "buttonBarBackgroundColor")!
        }
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //use kCLLocationAccuracyHundredMeters to conserve battery life
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
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
        restaurantSearchController = self.viewControllers[0] as! ResultRestaurantSearchViewController
         mapViewResultController = self.viewControllers[1] as! MapViewResultsViewController

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "searchlist")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapviewlistresult")
        return [child_1, child_2]
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

}
extension ParentViewController: CLLocationManagerDelegate {
    
    
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
            restaurantSearchController.searchRestaurantDefault(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            if mapViewResultController != nil {
                mapViewResultController.searchRestaurantDefault(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

            }
            let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let regionLocation = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(regionLocation, animated: true)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

extension ParentViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        coordinates = placemark.coordinate
        // clear existing pins
        restaurantSearchController.searchRestaurantDefault(latitude: (selectedPin?.coordinate.latitude)!, longitude: (selectedPin?.coordinate.longitude)!)

        if (mapViewResultController != nil) {
          mapViewResultController.searchRestaurantDefault(latitude: (selectedPin?.coordinate.latitude)!, longitude: (selectedPin?.coordinate.longitude)!)
            
        }
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
        
       
        
    }
}

extension ParentViewController : MKMapViewDelegate {
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

