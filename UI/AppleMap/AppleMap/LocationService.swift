//
//  LocationService.swift
//  AppleMap
//
//  Created by Rocoo on 2019/4/18.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import MapKit

class LocationService: NSObject, CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    
    override init(){
        super.init()
    }
    
    public typealias locationCallBack = (CLLocation) -> ()
    var callback: locationCallBack?
    
    
    func currentlyLocation(callback: @escaping locationCallBack){
        self.callback = callback
        checkLocationServices()
    }
    
    
    
}


// mark: - about location
extension LocationService{
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            print("PLease turn on location services or GPS")
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization(){
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Do map stuff
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert to instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{ return }
        self.callback?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}


