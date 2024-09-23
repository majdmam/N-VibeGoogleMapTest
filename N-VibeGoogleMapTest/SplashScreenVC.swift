//
//  SplashScreenVC.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import UIKit

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NavigationManager.core.moveToLandingVC(from: self)
    }
}
