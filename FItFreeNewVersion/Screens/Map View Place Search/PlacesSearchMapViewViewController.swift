//
//  PlacesSearchMapViewViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class PlacesSearchMapViewViewController: UIViewController {

    var locationManager = CLLocationManager()
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
      //  locationSearchTable.handleMapSearchDelegate = self


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PlacesSearchMapViewViewController: CLLocationManagerDelegate {
    
    
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
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let regionLocation = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(regionLocation, animated: true)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
/*
extension PlacesSearchMapViewViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
       
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city), \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}
*/
extension PlacesSearchMapViewViewController : MKMapViewDelegate {
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
