//
//  NavigationManager.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import UIKit


class NavigationManager {
    static let core = NavigationManager()
    
    func moveToLandingVC(from viewController: UIViewController) {
        let vc = LandingVC()
        vc.openInNewNavigationController(from: viewController)
    }
    
    func pushSearchAddressVC(from navigationController: UINavigationController?, delegate: SearchAddressVCDelegate, showMyLocationAsAnOption: Bool = false) {
        let vc = SearchAddressVC()
        vc.showMyLocationAsAnOption = showMyLocationAsAnOption
        vc.delegate = delegate
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushNavigationMapVC(from navigationController: UINavigationController?, startPlace: CustomPlace, destinationPlace: CustomPlace) {
        let vc = NavigationMapVC()
        vc.startPlace = startPlace
        vc.destinationPlace = destinationPlace
        navigationController?.pushViewController(vc, animated: true)
    }
}
