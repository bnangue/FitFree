//
//  MapViewResultsViewController.swift
//  FItFreeNewVersion
//
//  Created by Brice Nangue on 24.09.18.
//  Copyright © 2018 Brice  Nangue. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MapKit
import CDYelpFusionKit
import CoreLocation

struct ObjectAnnotation {
    var name: String?
    var coordinate: CDYelpCoordinates
}
class MapViewResultsViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var mapView: MKMapView!
    var restaurants: [ObjectAnnotation] = []
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //searchRestaurantDefault(latitude: 50.102482, longitude: 8.547457)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Map")
    }
    
    func pinAnnotation(latitude: Double, longtitude: Double)  {
        var listAnnotation: [MKPointAnnotation] = []
        if restaurants.count != 0
        {
            //
            for location in restaurants {
                let annotation = MKPointAnnotation()
                annotation.title = location.name
                annotation.coordinate.latitude = location.coordinate.latitude!
                annotation.coordinate.longitude = location.coordinate.longitude!
                listAnnotation.append(annotation)
            }
            if listAnnotation.count != 0 {
                //print("\(listAnnotation.count) mapview")
                if mapView != nil {
                    mapView.removeAnnotations(mapView.annotations)
                    self.mapView.addAnnotations(listAnnotation)
                    let region = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: latitude, longitude: longtitude), latitudinalMeters: 15000, longitudinalMeters: 15000)
                    mapView.setRegion(region, animated: true)
                }
                
                
            }else {
                print("No Annotations available")
            }
        }
        
    }
    func pinAnnotationOne(location: ObjectAnnotation)  {
        let annotation = MKPointAnnotation()
        annotation.title = location.name
        annotation.coordinate.latitude = location.coordinate.latitude!
        annotation.coordinate.longitude = location.coordinate.longitude!
        self.mapView.addAnnotation(annotation)
    
    }
    func searchRestaurantDefault(latitude: Double, longitude: Double) {
        restaurants = []
        // Cancel any API requests previously made
        //CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
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
                                                                        for business in businesses {
                                                                            self.restaurants.append(ObjectAnnotation(name: business.name, coordinate: business.coordinates!))
                                                                            //self.pinAnnotationOne(location: ObjectAnnotation(name: business.name, coordinate: business.coordinates!))
                                                                        }
                                                                        self.pinAnnotation(latitude: latitude, longtitude: longitude)
                                                                         //print("\(self.restaurants.count) after init mapview")
                                                                        // print("\(String(describing: businesses[0].toJSON()))")
                                                                        //for business in businesses {
                                                                        //   print("\(String(describing: business.toJSON()))")
                                                                        //}
                                                                        
                                                                    }
        }
    }
    
    func searchRestaurantFiltered(latitude: Double, longitude: Double, sortBy: CDYelpBusinessSortType?, priceTiers: [CDYelpPriceTier]?, openNow: Bool?, openAt: Int?) {
         restaurants = []
        // Cancel any API requests previously made
       // CDYelpFusionKitManager.shared.apiClient.cancelAllPendingAPIRequests()
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
                                                                 sortBy: sortBy,
                                                                 priceTiers: priceTiers,
                                                                 openNow: openNow,
                                                                 openAt: openAt,
                                                                 attributes: nil) { (response) in
                                                                    
                                                                    if let response = response,
                                                                        let businesses = response.businesses,
                                                                        businesses.count > 0 {
                                                                        for business in businesses {
                                                                            self.restaurants.append(ObjectAnnotation(name: business.name, coordinate: business.coordinates!))
                                                                            //self.pinAnnotationOne(location: ObjectAnnotation(name: business.name, coordinate: business.coordinates!))
                                                                        }
                                                                        self.pinAnnotation(latitude: latitude, longtitude: longitude)
                                                                         //print("\(self.restaurants.count) mapview")
                                                                        // print("\(String(describing: businesses[0].toJSON()))")
                                                                        //for business in businesses {
                                                                        //   print("\(String(describing: business.toJSON()))")
                                                                        //}
                                                                        
                                                                    }
        }
    }

}
