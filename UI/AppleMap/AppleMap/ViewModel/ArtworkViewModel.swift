//
//  ArtworkViewModel.swift
//  AppleMap
//
//  Created by Rocoo on 2019/4/16.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class ArtworkViewModel{
    
    init(){
        
    }
    
    lazy var locationService: LocationService = {
        return LocationService()
    }()    
    
    private let regionInMeters: Double = 10000
    
    typealias userLocationCallBack = (MKCoordinateRegion) -> ()
    
    var updateUserLocationCallback: userLocationCallBack?
    var updateAnnotations: (()->())?
    var updateIndicator: (()->())?
    var drawRoutes: (()->())?
    var resetRoutes: (()->())?
    
    var location: CLLocation? = nil
    
    var artworks: [Artwork] = [Artwork](){
        didSet{
            self.updateAnnotations?()
        }
    }
    
    var isIndicatorShown: Bool = false {
        didSet {
            self.updateIndicator?()
        }
    }
    
    var annitationCoordinate: CLLocationCoordinate2D? = nil{
        didSet{
            self.caculateRoutes()
        }
    }
    
    var routes: [MKRoute]? = nil{
        didSet{
            self.drawRoutes?()
        }
    }
    
    func fetchData(){
        
        self.isIndicatorShown = true
        
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            else {
                self.isIndicatorShown = false
                return
        }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            
            let json = try? JSONSerialization.jsonObject(with: data),
            
            let dictionary = json as? [String: Any],
            
            let works = dictionary["data"] as? [[Any]]
            else {
                self.isIndicatorShown = false
                return
                
        }        
        self.isIndicatorShown = false
        
        let validWorks = works.compactMap { Artwork(json: $0) }
        artworks.append(contentsOf: validWorks)
    }
    
    func locationRequest(){
        locationService.currentlyLocation { (location) in
            self.location = location            
            guard let coordinate = self.location?.coordinate else{ return }
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: self.regionInMeters, longitudinalMeters: self.regionInMeters)
            self.updateUserLocationCallback?(region)
        }
    }
    
    func caculateRoutes(){
        guard let location = self.location else{ return }
        let request = createDirectionsReqeust(from: location.coordinate)
        let directions = MKDirections(request: request)
        self.resetRoutes?()
        
        directions.calculate { [unowned self] (response, error) in
            
            if let error = error {
                print("we have error getting directions == \(error.localizedDescription)")
            }
            guard let response = response else { return }
            
            self.routes = response.routes
            
            if let _ = self.routes{
                self.drawRoutes?()
            }
        }
    }
    
    func createDirectionsReqeust(from userCoordinate: CLLocationCoordinate2D) -> MKDirections.Request{
        let sourcePlaceMark = MKPlacemark(coordinate: userCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlaceMark)
        let destinationPlaceMark = MKPlacemark(coordinate: self.annitationCoordinate ?? CLLocationCoordinate2D(latitude: -1, longitude: -1))
        request.destination = MKMapItem(placemark: destinationPlaceMark)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        
        return request
    }
    
    func updateUserLocation(callback: @escaping userLocationCallBack){
        self.updateUserLocationCallback = callback
    }
    
    
    
}
