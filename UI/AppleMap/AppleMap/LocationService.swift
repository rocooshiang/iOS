//
//  LocationService.swift
//  AppleMap
//
//  Created by Rocoo on 2019/4/18.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import MapKit

class LocationService: NSObject, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()

    override init() {
        super.init()
    }

    public typealias LocationCallBack = (CLLocation) -> Void
    var callback: LocationCallBack?

    func currentlyLocation(callback: @escaping LocationCallBack) {
        self.callback = callback
        checkLocationServices()
    }

}

// MARK: - about location
extension LocationService {

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            print("PLease turn on location services or GPS")
        }
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationAuthorization() {

        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Do map stuff
            locationManager.startUpdatingLocation()
        case .denied:
            // Show alert to instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }
        self.callback?(location)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

}
