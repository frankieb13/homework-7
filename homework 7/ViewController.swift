//
//  ViewController.swift
//  homework 7
//
//  Created by Frank Bonura on 4/15/20.
//  Copyright © 2020 Frank Bonura. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,
 CLLocationManagerDelegate {
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    let locMan: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    let honoluluLatitude: CLLocationDegrees = 21.31
    let honoluluLongitude: CLLocationDegrees = -157
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
           let newLocation: CLLocation=locations[0]
           NSLog("Something is happening")
           
           // horizontal accuracy less than than 0 means failure at gps level
           if newLocation.horizontalAccuracy >= 0 {
               
               
               let honolulu:CLLocation = CLLocation(latitude: honoluluLatitude,longitude: honoluluLongitude)

               let delta:CLLocationDistance = honolulu.distance(from: newLocation)
               
               let miles: Double = (delta * 0.000621371) + 0.5 // meters to rounded miles
               
               if miles < 3 {
                   // Stop updating the location
                   locMan.stopUpdatingLocation()
                   // Congratulate the user
                   distanceLabel.text = "Enjoy\nHonolulu!"
               } else {
                   let commaDelimited: NumberFormatter = NumberFormatter()
                   commaDelimited.numberStyle = NumberFormatter.Style.decimal
                   
                   distanceLabel.text=commaDelimited.string(from: NSNumber(value: miles))!+" miles to Honolulu"
               }
    
        }
        else
        {
            // add action if error with GPS
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locMan.distanceFilter = 1609; // a mile (in meters)
        locMan.requestWhenInUseAuthorization() // verify access to gps
        locMan.startUpdatingLocation()
        startLocation = nil
    }


}

