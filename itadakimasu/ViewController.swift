//
//  ViewController.swift
//  itadakimasu
//
//  Created by Sam Wang on 9/1/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager:CLLocationManager = CLLocationManager()
    var currentLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //locationmanager delegate function from CLLocationManager, called when user location updated
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("callign location manager")
        //store location in location variable of type CLLocation
        var location:CLLocation = locations[locations.count-1] as! CLLocation
        println(location)
        //check for location accuracy and stop when accurate enough
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            self.currentLocation = location
        }
    }
    
    //locationManager delegate function if failure
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}

