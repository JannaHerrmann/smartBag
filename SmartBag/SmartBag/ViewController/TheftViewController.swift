//
//  TheftViewController.swift
//  SmartBag
//
//  Created by Nicklas Linz on 26.06.18.
//  Copyright © 2018 Deutsches Forschungszentrum fuer Kuenstliche Intelligenz GmbH. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class TheftViewController : UIViewController, CLLocationManagerDelegate,  MKMapViewDelegate{
    
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    var lastLocation : CLLocation!
    var isCentered = false
    var lastConnected : MKPointAnnotation?

    
    @IBOutlet weak var theftOpening: UISwitch!
    @IBOutlet weak var outOfRangeOpening: UISwitch!

    
    func loadPin(){
        if (ViewController.showPins){
            if (lastConnected == nil){
                lastConnected = MKPointAnnotation()
                lastConnected?.title = "Theft Point"
                lastConnected?.coordinate = CLLocationCoordinate2D(latitude: self.lastLocation.coordinate.latitude, longitude: self.lastLocation.coordinate.longitude)
                mapView.addAnnotation(lastConnected!)
            }
        }
    }
    
    override func viewDidLoad() {
        self.optionView.layer.borderWidth = 1.0
        self.optionView.layer.borderColor = #colorLiteral(red: 0.2056839466, green: 0.4766893387, blue: 0.4690987468, alpha: 1)
        ViewController.alerrtTheftOpen = theftOpening.isOn
        outOfRangeOpening.isOn = ViewController.alerOutOfRange
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
    @IBAction func openingAlarm(_ sender: UISwitch) {
        ViewController.alerrtTheftOpen = sender.isOn
    }
    
    @IBAction func outOfRangeAlarm(_ sender: UISwitch) {
        ViewController.alerOutOfRange = sender.isOn
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
            loadPin()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
