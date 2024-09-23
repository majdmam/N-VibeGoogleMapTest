//
//  BaseViewController.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    var viewModel: T!
    var loadingView: UIView!
    var firstAppear = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegation()
        addLoadingIndicator()
        setupViewModel()
        loadData()
        configureDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstAppear {
            firstAppear = false
            viewWillFirstAppear()
        } else {
            self.updateData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func addLoadingIndicator() {
        loadingView = UIView.makeDefaultLoadingView()
        view.addSubview(loadingView)
        loadingView.pinEdges(to: self.view)
    }
    
    func viewWillFirstAppear() {
        self.fillScentences()
    }
    
    func configureDelegation() {
        
    }
    
    func loadData() {
        
    }
    
    func updateData() {
        
    }
    
    func configureDesign() {
        self.view.backgroundColor = .secondarySystemBackground
    }
    
    func setupHeroIDs() {
        
    }
    
    func fillScentences() {
        
    }
    
    func configureErrorMessage() {
        
    }
    
    func configureOneSignalNavigation() {
        
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
    }
    
    func setupViewModel(){
        self.viewModel?.loading.bind {
            [weak self] val in
            guard let v = val else { return }
            if v { self?.showLoadingView() } else { self?.hideLoadingView() }
        }
    }
}
