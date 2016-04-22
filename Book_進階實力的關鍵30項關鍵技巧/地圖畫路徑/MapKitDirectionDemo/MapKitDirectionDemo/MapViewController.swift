//
//  MapViewController.swift
//  MapKitDirectionDemo
//
//  Created by Rocoo on 2016/4/22
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  
  let locationManager = CLLocationManager()
  var currentPlacemark : CLPlacemark?
  var latestLocation : CLLocationCoordinate2D?
  var destination : CLLocationCoordinate2D?
  var restaurant = Restaurant!()
  var currentTransportType = MKDirectionsTransportType.Automobile
  var currentRoute : MKRoute?
  
  @IBOutlet weak var mapView:MKMapView!
  @IBOutlet var segmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    segmentedControl.hidden = true
    segmentedControl.addTarget(self, action: "showDirection:", forControlEvents: .ValueChanged)
    
    //授權請求
    locationManager.requestWhenInUseAuthorization()
    let status = CLLocationManager.authorizationStatus()
    if status == .AuthorizedWhenInUse{
      self.mapView.showsUserLocation = true
      //開始持續更新使用者位置
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
    
    mapView.delegate = self
    
    // Convert address to coordinate and annotate it on map
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(restaurant.address, completionHandler: { placemarks, error in
      
      if error != nil {
        print(error)
        return
      }
      
      let placemark = placemarks![0] as CLPlacemark
      self.currentPlacemark = placemark
      
      if let placemarks = placemarks {
        
        // Get the first placemark
        let placemark = placemarks[0]
        
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.title = self.restaurant.name
        annotation.subtitle = self.restaurant.category
        
        if let location = placemark.location {
          annotation.coordinate = location.coordinate
          self.destination = location.coordinate
          
          // Display the annotation
          self.mapView.showAnnotations([annotation], animated: true)
          self.mapView.selectAnnotation(annotation, animated: true)
        }
      }
    })
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "MyPin"
    
    if annotation.isKindOfClass(MKUserLocation) {
      return nil
    }
    
    // Reuse the annotation if possible
    var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
    
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true
    }
    
    let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
    leftIconView.image = UIImage(named: restaurant.image)!
    annotationView?.leftCalloutAccessoryView = leftIconView
    
    annotationView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
    
    // Pin color customization
    if #available(iOS 9.0, *) {
      annotationView?.pinTintColor = UIColor.orangeColor()
    }
    
    return annotationView
  }
  
  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    
    //設定路徑的外觀
    let renderer = MKPolylineRenderer(overlay: overlay)
    renderer.strokeColor = (currentTransportType == .Automobile) ? UIColor.greenColor() : UIColor.magentaColor()
    renderer.lineWidth = 3.0
    
    return renderer
  }
  
  func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
    self.performSegueWithIdentifier("showSteps", sender: view)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showSteps"{
      let destinationController = segue.destinationViewController as! UINavigationController
      let routeTableViewController = destinationController.childViewControllers.first as! RouteTableViewController
      if let steps = currentRoute!.steps as? [MKRouteStep]{
        routeTableViewController.routeSteps = steps
      }
    }
  }
  
  
  @IBAction func showDirection(sender: AnyObject) {
    
    //判斷是Car還是Walking
    if segmentedControl.selectedSegmentIndex == 0{
      currentTransportType = .Automobile
    }else{
      currentTransportType = .Walking
    }
    self.segmentedControl.hidden = false
    
    let directionRequest = MKDirectionsRequest()
    
    //起始位置
    directionRequest.source = MKMapItem.mapItemForCurrentLocation()
    
    //目的地
    let destinationPlacemark = MKPlacemark(placemark: currentPlacemark!)
    directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
    
    //運輸類型
    directionRequest.transportType = currentTransportType
    
    //啟用替代道路(會回傳多個路徑)
    //directionRequest.requestsAlternateRoutes = true
    
    //方位計算
    let directions = MKDirections(request: directionRequest)
    directions.calculateDirectionsWithCompletionHandler { (routeResponse, routeError) -> Void in
      
      if routeError != nil{
        print("Error in showDirection button: \(routeError?.localizedDescription)")
      }else{
        //取得路徑疊到地圖上
        let route = (routeResponse?.routes[0])! as MKRoute
        self.currentRoute = route
        self.mapView.removeOverlays(self.mapView.overlays)
        self.mapView.addOverlay(route.polyline, level: .AboveRoads)
        
        if (self.latestLocation != nil) {
          
          //設定看到地圖的遠近
          let span = MKCoordinateSpanMake(0.1, 0.1)
          
          //取得目的地與使用者位置的中心點
          let lat = (Double((self.destination?.latitude)!) + Double((self.latestLocation?.latitude)!)) / 2
          let lon = (Double((self.destination?.longitude)!) + Double((self.latestLocation?.longitude)!)) / 2
          
          //設定地圖顯示的中心點
          let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(lat, lon), span: span)
          
          self.mapView.setRegion(region, animated: true)
        }
      }
    }
  }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController : CLLocationManagerDelegate{
  //持續更新使用者位置
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last
    
    latestLocation = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
  }
}

