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
    let regionRadius: CLLocationDistance = 500
    var businessURL: NSURL!
    var numbers: [Int] = []
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var yelpStarRatingImage: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        //Set Nav Bar title text and edit font style of leftbar button in navbar
        self.navigationItem.title = "ITADAKIMASU"
        self.loadingIndicator.startAnimating()
        self.mapView.hidden = true
        self.mapView.showsUserLocation = true
        
        //check if location is nil so application doesn't crash in case where it is nil
        if self.Loc?.coordinate != nil {
            centerMapOnLocation(self.Loc!)
            callyelp("food", searchLimit: 20, searchLocation: self.Loc!, category: "restaurants", searchRadius: 2000)
        } else {
            displayError("Can't Find Your Location", error: "")
        }
    }
    
    //helper method to call yelpAPI with yelpAPIClient and Business class
    func callyelp(searchTerm: String, searchLimit: Int, searchLocation: CLLocation, category: String, searchRadius: Int){
        Business.searchByLocationRatingDistance(searchTerm, limit: searchLimit, Lat: searchLocation.coordinate.latitude, Long: searchLocation.coordinate.longitude, sort: 1, categories: category, radius_filter: searchRadius, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            println("calling Yelp API function")
            self.displayBusinessInformation(self.businessPicker(self.businesses))
        })
    }
    
    //method used to pick yelp business, avoid duplicates as well
    func businessPicker(businessList: [Business]) -> Business {
        if numbers.count == 0 {
            numbers = Array(0 ... businessList.count - 1)
        }
        var randomIndex = Int(arc4random_uniform(UInt32(numbers.count)))
        var ran = numbers.removeAtIndex(randomIndex)
        return businessList[ran]
    }
    
    //method used to display information in view
    func displayBusinessInformation(business: Business) {
        
        //map annotation for business after converting address to coordinate
        var convertCoord: CLLocation?
        var geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(business.address!) {
            self.mapView.removeAnnotations(self.mapView.annotations)
            if let placemarks = $0 {
                convertCoord = placemarks[0].location

                let annot = BusinessAnnotation(title: business.name!, locationName: business.address!, discipline: "Business", coordinate: convertCoord!.coordinate)
                self.mapView.addAnnotation(annot)
                self.mapView.delegate = self
                
            } else {
                println($1)
            }
        }
        
        self.businessURL = business.mobileUrl!
        let data = NSData(contentsOfURL: business.ratingImageURL!)
        self.yelpStarRatingImage.image = UIImage(data: data!)
        let str = "\(business.reviewCount!)" + " Reviews"
        self.reviewCountLabel.text = str
        self.categoriesLabel.text = business.categories!
        self.businessNameLabel.text = business.name!
        self.distanceLabel.text = business.distance!
        self.loadingIndicator.hidden = true
        self.loadingIndicator.stopAnimating()
        self.mapView.hidden = false
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func refreshRestaurant(sender: AnyObject) {
        //self.mapView.removeAnnotations(self.mapView.annotations)
        displayBusinessInformation(businessPicker(self.businesses))
    }
    
    @IBAction func openInYelp(sender: AnyObject) {
        if(UIApplication.sharedApplication().canOpenURL(self.businessURL)){
            UIApplication.sharedApplication().openURL(self.businessURL)
        }
    }

    /* general helper function for error to prompt user with an alert */
    func displayError(alertTitle: String, error: String) {
        let alert = UIAlertView()
        alert.title = alertTitle
        alert.message = error
        alert.addButtonWithTitle("OK")
        alert.show()
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





