//
//  MyLocationManager.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import UIKit
import CoreLocation

class MyLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = MyLocationManager()
    
    //private
    private var _lat = 0.0
    private var _lon = 0.0
    private var locationManager = CLLocationManager()
    private var isStopLocation = true
    
    var didLocateCurrentLocation:((Double,Double) -> Void)?
    var locationDidChange:((CLLocation) -> Void)?
    private(set) var lastDetectedLocation: CLLocation?
    //MARK: Location
    func startLocation(_ isStopLocation:Bool = true){
        self.isStopLocation = isStopLocation
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse , .authorizedAlways:
            manager.startUpdatingLocation()
            
            guard let loc = locationManager.location else {return}
            let lat = loc.coordinate.latitude
            let lon = loc.coordinate.longitude
            print("First => latitude : \(lat) || longitude : \(lon)" )

            break
        case .denied , .restricted:
            manager.requestWhenInUseAuthorization()
            break
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else { return }
        if isStopLocation {
            locationManager.stopUpdatingLocation()
            manager.delegate = nil
        }
        
        _lat = first.coordinate.latitude
        _lon = first.coordinate.longitude
        print("Inner => latitude : \(_lat) || longitude : \(_lon)" )
        lastDetectedLocation = first
        locationDidChange?(first)
        didLocateCurrentLocation?(_lat,_lon)
    }
}
