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
        
        viewModel.updateAnnotations = { [weak self] () in
            guard let `self` = self else{
                return
            }
            self.mapView.addAnnotations(self.viewModel.artworks)
        }
        
        
        viewModel.updateUserLocation { [weak self] (region) in    
            self?.mapView.setRegion(region, animated: true)
        }
        
        
        viewModel.updateIndicator = { [weak self] () in
            self?.indicator.isHidden = self?.viewModel.isIndicatorShown ?? false ? false : true
        }
        
        viewModel.drawRoutes = { [weak self] () in
            
            guard let `self` = self, let routes = self.viewModel.routes else{
                return
            }
            
            let _ = routes.map{
                self.mapView.addOverlay($0.polyline, level: .aboveRoads)
                self.mapView.setVisibleMapRect($0.polyline.boundingMapRect, animated: true)
            }
        }
        
        viewModel.resetRoutes = { [weak self] () in
            guard let overlays = self?.mapView.overlays else { return }
            self?.mapView.removeOverlays(overlays)
            
        }
        
        
        
        viewModel.fetchData()
        viewModel.locationRequest()
        
    }
    
    
}




extension ViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation else{
            return
        }
        
        self.viewModel.annitationCoordinate = annotation.coordinate
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
}
