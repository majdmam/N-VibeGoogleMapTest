//
//  Constants.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import Foundation

extension AddressSearchResultTextFieldTag {
    static let startAddressTextField = 100
    static let destinationAddressTextField = 200
}

struct Constants {
    static var toastAfter: Int = 250
    
    struct SecretKeys {
        static let GoogleMapsSecretKey = "AIzaSyB9pETNexCpFb8EWal9YoSUSK30kMTE3lQ"
    }
    
    enum Images: String {
        case errorTriangle = "error-triangle"
        case success2 = "success2"
    }
}
