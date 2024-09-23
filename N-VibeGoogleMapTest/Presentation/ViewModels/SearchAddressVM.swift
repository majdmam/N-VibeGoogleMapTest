//
//  SearchAddressVM.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import Foundation
import GooglePlaces

class SearchAddressVM: BaseViewModel {
    var searchResult: Box<[GMSAutocompletePrediction]> = Box([])
    var placesNames: Box<[NSAttributedString]> = Box([])
}
