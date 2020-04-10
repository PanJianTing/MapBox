//
//  ViewController.swift
//  MapBoxDemo
//
//  Created by panjianting on 2020/4/6.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager();
    var mapView = MGLMapView();
    var isSetCenter = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isSetCenter = false;
        
        self.locationManager.requestAlwaysAuthorization();
        self.locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        self.mapView = MGLMapView(frame: view.bounds, styleURL: url);
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        self.mapView.setCenter(CLLocationCoordinate2D(latitude: 24.96, longitude: 121.544), zoomLevel: 9, animated: false);
        self.mapView.showsUserLocation = true
        view.addSubview(self.mapView)
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if(!self.isSetCenter){
            self.mapView.setCenter(CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude), animated: true);
            self.isSetCenter = true;
        }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

