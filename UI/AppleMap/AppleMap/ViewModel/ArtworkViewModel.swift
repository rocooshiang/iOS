//
//  ArtworkViewModel.swift
//  AppleMap
//
//  Created by Rocoo on 2019/4/16.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import CoreLocation

class ArtworkViewModel{
    
    init(){
        
    }
    
    lazy var locationService: LocationService = {
       return LocationService()
    }()    
    
    var reloadMapView: (()->())?
    var updateIndicator: (()->())?
    
    var artworks: [Artwork] = [Artwork](){
        didSet{
            self.reloadMapView?()
        }
    }
    
    var isIndicatorShown: Bool = false {
        didSet {
            self.updateIndicator?()
        }
    }
    
    var location: CLLocation? = nil {
        didSet{
            self.reloadMapView?()
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
        }
    }
    
    
}
