//
//  ViewController.swift
//  AppleMap
//
//  Created by Rocoo on 2019/2/14.
//  Copyright © 2019 Rocoo. All rights reserved.
//


#warning ("TODO: MVVM")
#warning ("TODO: RxSwift")
#warning ("TODO: Codeable")



import UIKit
import MapKit


class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var artworks: [Artwork] = []
    var locationManager = CLLocationManager()
    var destinationPlaceMark: MKPlacemark!
    let regionInMeters: Double = 10000
    var isInitCenterView = false
    var directionsArray = [MKDirections]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapData()
        checkLocationServices()
        
    }
    
    func initMapData(){
        
        loadInitialData()
        mapView.delegate = self
        mapView.register(ArtworkView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.addAnnotations(artworks)
    }
    
    
    
    func loadInitialData() {
        
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            
            let json = try? JSONSerialization.jsonObject(with: data),
            
            let dictionary = json as? [String: Any],
            
            let works = dictionary["data"] as? [[Any]]
            else { return }
        
        let validWorks = works.compactMap { Artwork(json: $0) }
        artworks.append(contentsOf: validWorks)
    }
    
    
    
    
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
            mapView.showsUserLocation = true
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
    
    func centerMapViewOnUserLocation(coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func drawRoutes(){
        guard let location = locationManager.location?.coordinate else{
            return
        }
        
        let request = createDirectionsReqeust(from: location)
        let directions = MKDirections(request: request)
        resetMapView(directions: directions)
        
        directions.calculate { [unowned self] (response, error) in
        
            if let error = error {
                print("we have error getting directions == \(error.localizedDescription)")
            }
            guard let response = response else { return }
            
            for route in response.routes{
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            
        }
    }
    
    func createDirectionsReqeust(from userCoordinate: CLLocationCoordinate2D) -> MKDirections.Request{
        let sourcePlaceMark = MKPlacemark(coordinate: userCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlaceMark)
        request.destination = MKMapItem(placemark: destinationPlaceMark)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        
        return request
    }
    
    func resetMapView(directions: MKDirections){
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map{ $0.cancel()}        
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}




extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{ return }
        
        if isInitCenterView == false{
            isInitCenterView = true
            centerMapViewOnUserLocation(coordinate: location.coordinate)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}








extension ViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation else{
            return
        }
        
        destinationPlaceMark = MKPlacemark(coordinate: annotation.coordinate)
        
        drawRoutes()
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    
    
    func getAddressDetail(location: CLLocation){
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let _ = self else { return }
            
            if let _ = error{
                // show alert information to user
                return
            }
            
            guard let placemarks = placemarks?.first else{
                // show alert information to user
                return
            }
            
            let streetNumber = placemarks.subThoroughfare ?? ""
            let streetName = placemarks.thoroughfare ?? ""
            
            print("street number: \(streetNumber), name: \(streetName)")
        }
    }
    
}
