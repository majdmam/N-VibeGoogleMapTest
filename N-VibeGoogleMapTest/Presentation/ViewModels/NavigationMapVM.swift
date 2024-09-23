//
//  File.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import GooglePlaces

class NavigationMapVM: BaseViewModel {
    var start: Box<CLLocationCoordinate2D> = Box(nil)
    var destination: Box<CLLocationCoordinate2D>
    
    init(start: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        self.start = Box(start)
        self.destination = Box(destination)
    }
}
