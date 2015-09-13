//
//  MapViewExtension.swift
//  itadakimasu
//
//  Created by Sam Wang on 9/13/15.
//  Copyright (c) 2015 eightAM. All rights reserved.
//

import MapKit

extension BusinessInformationViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            if let annotation = annotation as? BusinessAnnotation {
                let identifier = "pin"
                var view: MKPinAnnotationView
                if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                    as? MKPinAnnotationView { // 2
                        dequeuedView.annotation = annotation
                        view = dequeuedView
                } else {
                    // 3
                    view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view.canShowCallout = true
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
                }
                return view
            }
            return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let location = view.annotation as! BusinessAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }

}