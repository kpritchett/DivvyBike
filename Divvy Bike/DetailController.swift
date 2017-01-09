//
//  DetailController.swift
//  Divvy Bike
//
//  Created by Student on 10/14/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import MapKit

class DetailController: UIViewController
{
    var detailItem : [String : String]!
    @IBOutlet weak var myMapView: MKMapView!
    override func viewDidLoad()
    {
        //places marker on the map after converting latitude and longitude strings into doubles and then using those doubles.
        super.viewDidLoad()
        let myPin = MKPointAnnotation()
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let a:Double? = Double(detailItem["latitude"]!)
        let b:Double? = Double(detailItem["longitude"]!)
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(a!, b!)
        myPin.coordinate = pinLocation
        let region = MKCoordinateRegionMake((myPin.coordinate), span)
        self.myMapView.setRegion(region, animated: true)
        self.myMapView.addAnnotation(myPin)
    }
}