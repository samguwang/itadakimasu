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


class BusinessInformationViewController: ViewController {
    
    var Loc: CLLocation?
    var businesses: [Business]!
    
    override func viewDidLoad() {
        self.navigationItem.title = "ITADAKIMASU"
        println(self.Loc)
        Business.searchByLocationRatingDistance("food", limit: 20, Lat: Loc!.coordinate.latitude, Long: Loc!.coordinate.longitude, sort: 0, categories: "restaurants", radius_filter: 2000, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            println("calling callAPI function")
            let top = businesses.endIndex
            let ran = self.randRange(0, upper: top)
            var selectedBusiness = businesses[ran]
            let businame = selectedBusiness.name!
            println(businame)
            println(selectedBusiness.ratingImageURL)
        })
    }
}