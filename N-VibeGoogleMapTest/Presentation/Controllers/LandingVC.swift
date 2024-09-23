//
//  LandingVC.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import UIKit
import GoogleMaps
import GooglePlaces

class LandingVC: BaseViewController<LandingVM> {
    var mainStack: UIStackView!
    var startingAddressTextField: AddressSearchResultTextField!
    var destinationAddressTextField: AddressSearchResultTextField!
    var searchResultTarget: AddressSearchResultTextFieldTag?
    
    let showNavigationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("Open In Map", for: .normal)
        button.backgroundColor = .label
        button.fixedHeightConstraint(height: 48)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureDesign() {
        super.configureDesign()
        mainStack = setupMainStack()
        
        startingAddressTextField = addressSearchTextField(settings: .init(placeHolder: "  Enter Starting Address...", tag: .startAddressTextField))
        mainStack.addArrangedSubview(startingAddressTextField)
        
        destinationAddressTextField = addressSearchTextField(settings: .init(placeHolder: "  Enter Destination Address...", tag: .destinationAddressTextField))
        mainStack.addArrangedSubview(destinationAddressTextField)
        
        mainStack.addArrangedSubview(showNavigationButton)
        showNavigationButton.addTarget(self, action: #selector(showNavigationButtonClicked), for: .touchUpInside)
    }
    
    func addressSearchTextField(settings: AddressSearchResultTextFieldSettings) -> AddressSearchResultTextField {
        let addressTextField = AddressSearchResultTextField()
        addressTextField.delegate = self
        addressTextField.setup(settings: settings)
        return addressTextField
    }
    
    override func setupViewModel() {
        viewModel = LandingVM()
        super.setupViewModel()
        viewModel.startingPlace.bind {
            value in
            if let place = value {
                self.startingAddressTextField?.textField.attributedText = place.placeName
            }
        }
        viewModel.destinationPlace.bind {
            value in
            if let place = value {
                self.destinationAddressTextField?.textField.attributedText = place.placeName
            }
        }
    }
    
    @objc func showNavigationButtonClicked() {
        if let startPlace = viewModel.startingPlace.value, let destinationPlace = viewModel.destinationPlace.value {
            NavigationManager.core.pushNavigationMapVC(from: navigationController, startPlace: startPlace, destinationPlace: destinationPlace)
        } else {
            // handle select valid addresses
        }
    }
    
    func setupMainStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stack)
        stack.pinSidesAndTop(to: self.view.layoutMarginsGuide)
        return stack
    }
}

extension LandingVC: AddressSearchResultTextFieldDelegate {
    func textFieldShouldBeginEditing(_ addressSearchResultTextField: AddressSearchResultTextField) {
        searchResultTarget = addressSearchResultTextField.viewTag
        NavigationManager.core.pushSearchAddressVC(from: self.navigationController, delegate: self, showMyLocationAsAnOption: searchResultTarget == .startAddressTextField)
    }
}

extension LandingVC: SearchAddressVCDelegate {
    func addressHasBeenSelected(_ place: CustomPlace) {
        if searchResultTarget == .destinationAddressTextField {
            viewModel.destinationPlace.value = place
        } else {
            viewModel.startingPlace.value = place
        }
        searchResultTarget = nil
    }
    
    func addressHasBeenSelected(_ place: GMSPlace) {
    }
    
    func addressHasBeenSelected(_ coordinate: CLLocationCoordinate2D, placeName: String) {
        
    }
}

