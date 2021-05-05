//
//  MapView.swift
//  Petulia
//
//  Created by Benjamin Simpson on 4/29/21.
//  Copyright © 2021 Johandre Delgado . All rights reserved.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation

struct MapView: UIViewRepresentable {
  
  var address: String
  var locationManager = CLLocationManager()
  @State var coordinate = CLLocationCoordinate2D()
  //@Binding var pins: [Pin]
  
  func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: .zero)
     //mapView.userTrackingMode = .follow
    return mapView
    
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
    //let location = address.address1
    //uiView.addAnnotation(pins as! MKAnnotation)
    setupManager()
    coordinates(forAddress: address) { (location) in
      guard let location = location else {
        return
      }
      coordinate = location
      let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
      let region = MKCoordinateRegion(center: coordinate, span: span)
      uiView.setRegion(region, animated: true)
      
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
    }
    
    
  }
  
  func setupManager(){
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
    let geoLocator = CLGeocoder()
    geoLocator.geocodeAddressString(address) { (petAddress, error) in
      guard error == nil else {
        print("Location issue: \(error!)")
        return completion(nil)
      }
      completion(petAddress?.first?.location?.coordinate)
    }
  }
}

class Pin: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  
  init(title: String?, coordinate: CLLocationCoordinate2D){
    self.title = title
    self.coordinate = coordinate
  }
}
