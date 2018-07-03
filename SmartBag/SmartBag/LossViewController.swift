//
//  LossViewController.swift
//  SmartBag
//
//  Created by Janna Herrmann on 03.07.18.
//  Copyright © 2018 Deutsches Forschungszentrum fuer Kuenstliche Intelligenz GmbH. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation


class LostViewController : UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    var lastLocation : CLLocation!
    var isCentered = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.optionView.layer.borderWidth = 1.0
        self.optionView.layer.borderColor = #colorLiteral(red: 0.2056839466, green: 0.4766893387, blue: 0.4690987468, alpha: 1)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
    func centerView(){
        self.mapView.setCenter(lastLocation.coordinate, animated: true)
        self.mapView.setRegion(MKCoordinateRegionMake(lastLocation.coordinate, MKCoordinateSpan.init(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        lastLocation = userLocation
        
        //center once at the start
        if (!isCentered){
            isCentered = true
            self.centerView()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
