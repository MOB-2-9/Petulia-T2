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

struct MapView: UIViewRepresentable {
  
  var address: Address
  var locationManager = CLLocationManager()
  @State var coordinate = CLLocationCoordinate2D()
  @Binding var pins: [Pin]
  
  func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: .zero)
    mapView.userTrackingMode = .follow
    return mapView
    
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
    //let location = address.address1
    uiView.addAnnotation(pins as! MKAnnotation)
  }
  
  func setupManager(){
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
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
