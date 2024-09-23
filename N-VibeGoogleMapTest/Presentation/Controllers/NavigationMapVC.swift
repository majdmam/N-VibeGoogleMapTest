//
//  NavigationMapVC.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import UIKit
import GoogleMaps
import GooglePlaces

class NavigationMapVC: BaseViewController<NavigationMapVM> {
    var mapView: GMSMapView!
    var startPlace: CustomPlace!
    var destinationPlace: CustomPlace!
    var marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let options = GMSMapViewOptions()
//        options.camera = GMSCameraPosition(latitude: startPlace.coordinate.latitude, longitude: startPlace.coordinate.longitude, zoom: 12)
        options.frame = self.view.bounds;

        mapView = GMSMapView(options:options)
        self.view = mapView
        if startPlace.place == nil {
            MyLocationManager.shared.locationDidChange = lastLocationChanged
            MyLocationManager.shared.startLocation(false)
        }
    }
    
    func addMarker(at coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
        marker.title = "Me"
        marker.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayRoute()
    }
    
    override func setupViewModel() {
        viewModel = NavigationMapVM(start: startPlace.coordinate, destination: destinationPlace.coordinate)
        super.setupViewModel()
    }
    
    private func lastLocationChanged(location: CLLocation) {
//        viewModel.start.value = location.coordinate
        addMarker(at: location.coordinate)
    }
    
    private func displayRoute() {
        if let start = viewModel.start.value, let destination = viewModel.destination.value {
            GooglePlacesSearchManager.shared.getWalkingRoute(start: start, destination: destination) { polyline, error in
                DispatchQueue.main.async {
                    if let polyline = polyline {
                        self.showRoute(polyline: polyline)
                    } else if let err = error {
                        self.navigationController?.popViewController(animated: true)
                        self.showWarningToastAfter(message: err)
                    }
                }
            }
        }
    }
    
    private func showRoute(polyline: GMSPolyline) {
        polyline.strokeColor = .blue
        polyline.strokeWidth = 4.0
        polyline.map = mapView
        let bounds = GMSCoordinateBounds(coordinate: viewModel.start.value!, coordinate: viewModel.destination.value!)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.animate(with: update)
    }
}
