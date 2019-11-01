//
//  Artwork.swift
//  AppleMap
//
//  Created by Rocoo on 2019/2/15.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import MapKit
import Contacts

/***
     Artwork must subclass NSObject, because MKAnnotation is an NSObjectProtocol.
 ***/

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D

    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate

        super.init()
    }

    init?(json: [Any]) {
        // 1
        self.title = json[16] as? String ?? "No Title"
        self.locationName = json[11] as? String ?? "No Location Name"
        self.discipline = json[15] as? String ?? "No discipiline"
        // 2
        if let latitude = Double(json[18] as? String ?? "0"),
            let longitude = Double(json[19] as? String ?? "0") {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }

    var subtitle: String? {
        return locationName
    }

    // markerTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor {
        switch discipline {
        case "Monument":
            return .red
        case "Mural":
            return .cyan
        case "Plaque":
            return .blue
        case "Sculpture":
            return .purple
        default:
            return .green
        }
    }

    var imageName: String? {
        if discipline == "Sculpture" { return "Statue" }
        return "Flag"
    }

    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
