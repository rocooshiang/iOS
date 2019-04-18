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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    var destinationPlaceMark: MKPlacemark!
    let regionInMeters: Double = 10000
    var isInitCenterView = false
    var directionsArray = [MKDirections]()
    
    lazy var viewModel: ArtworkViewModel = {
        return ArtworkViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapData()
        
    }
    
    func initMapData(){
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.register(ArtworkView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        viewModel.reloadMapView = { [weak self] () in
            guard let `self` = self else{
               return
            }
            self.mapView.addAnnotations(self.viewModel.artworks)
            self.centerMapViewOnUserLocation(location: self.viewModel.location)
        }
        
        viewModel.updateIndicator = { [weak self] () in
            self?.indicator.isHidden = self?.viewModel.isIndicatorShown ?? false ? false : true
        }
        
        viewModel.fetchData()
        viewModel.locationRequest()
        
    }
    
    
    func centerMapViewOnUserLocation(location: CLLocation?){
        guard let coordinate = location?.coordinate else{ return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func drawRoutes(){
        guard let location = self.viewModel.location else{ return }
        let request = createDirectionsReqeust(from: location.coordinate)
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
    
}
