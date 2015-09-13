//
//  BusinessInformationViewController.swift
//  itadakimasu
//
//  Created by Sam Wang on 9/10/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class BusinessInformationViewController: ViewController {
    
    var Loc: CLLocation?
    var businesses: [Business]!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 200
    
    override func viewDidLoad() {
        //Set Nav Bar title text and edit font style of leftbar button in navbar
        self.navigationItem.title = "ITADAKIMASU"
        self.loadingIndicator.startAnimating()
        self.mapView.hidden = true
        self.mapView.showsUserLocation = true
        centerMapOnLocation(self.Loc!)
    }
    
    override func viewDidAppear(animated: Bool) {
        callyelp("food", searchLimit: 10, searchLocation: self.Loc!, category: "restaurants", searchRadius: 2000)

    }
    
    //helper method to call yelpAPI with yelpAPIClient and Business class
    func callyelp(searchTerm: String, searchLimit: Int, searchLocation: CLLocation, category: String, searchRadius: Int){
        Business.searchByLocationRatingDistance(searchTerm, limit: searchLimit, Lat: searchLocation.coordinate.latitude, Long: searchLocation.coordinate.longitude, sort: 0, categories: category, radius_filter: searchRadius, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            println("calling callAPI function")
//            let top = businesses.endIndex
//            let ran = self.randRange(0, upper: top)
//            var selectedBusiness = businesses[ran]
//            let businame = selectedBusiness.name!
//            println(businame)
           // println(selectedBusiness.ratingImageURL)
            self.displayBusinessInformation(self.businessPicker(self.businesses))
        })
    }
    
    //method used to pick yelp business
    func businessPicker(businessList: [Business]) -> Business {
        var randomIndex = Int(arc4random_uniform(UInt32(businessList.endIndex)))
        println(randomIndex)
        return businessList[randomIndex]
    }
    
    
    //method used to display information in view
    func displayBusinessInformation(business: Business) {
        println(business.name)
        println(business.ratingImageURL)
        
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
        self.mapView.hidden = false
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}