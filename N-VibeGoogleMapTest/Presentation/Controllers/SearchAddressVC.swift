//
//  SearchAddressVC.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import UIKit
import GooglePlaces

protocol SearchAddressVCDelegate {
//    func addressHasBeenSelected(_ address: GMSPlace)
//    func addressHasBeenSelected(_ coordinate: CLLocationCoordinate2D)
//    func addressHasBeenSelected(_ coordinate: CLLocationCoordinate2D, placeName: String)
    func addressHasBeenSelected(_ place: CustomPlace)
}

class SearchAddressVC: BaseViewController<SearchAddressVM> {
    
    let setupMainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.fixedHeightConstraint(height: 48)
        textField.placeholder = "  Enter Search Key ..."
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let tableOfContent: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.fixedHeightConstraint(height: 600)
        return tableView
    }()
    
    var showMyLocationAsAnOption: Bool = false
    var delegate: SearchAddressVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTextField.becomeFirstResponder()
    }
    
    override func configureDesign() {
        super.configureDesign()
        view.addSubview(setupMainStack)
        setupMainStack.pinSidesAndTop(to: self.view.layoutMarginsGuide)
        
        searchTextField.addTarget(self, action: #selector(textFieldTextDidChanged), for: .editingChanged)
        setupMainStack.addArrangedSubview(searchTextField)
        searchTextField.pinSidesAndTop(to: self.view.layoutMarginsGuide)
        
        setupMainStack.addArrangedSubview(tableOfContent)
        tableOfContent.register(name: .addressSearchResultTableViewCell)
    }
    
    override func configureDelegation() {
        super.configureDelegation()
        tableOfContent.dataSource = self
        tableOfContent.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func setupViewModel() {
        viewModel = SearchAddressVM()
        super.setupViewModel()
        viewModel.searchResult.bind {
            value in
            self.tableOfContent.reloadData()
        }
    }
}

extension SearchAddressVC {
    @objc func textFieldTextDidChanged() {
        GooglePlacesSearchManager.shared.searchPlaces(with: searchTextField.text ?? "") {
            result in
            if let res = result {
                var placesNames: [NSAttributedString] = []
                placesNames.append(contentsOf: res.map{$0.attributedPrimaryText})
                if self.showMyLocationAsAnOption, let _ = MyLocationManager.shared.lastDetectedLocation?.coordinate {
                    placesNames.insert(.myLocation, at: 0)
                }
                self.viewModel.placesNames.value = placesNames
                self.viewModel.searchResult.value = res
            } else {
                self.viewModel.placesNames.value = []
                self.viewModel.searchResult.value = []
            }
        }
    }
}

extension SearchAddressVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.placesNames.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressSearchResultTableViewCell()
        if let results = viewModel.placesNames.value, results.count > indexPath.row {
            cell.config(model: results[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let results = viewModel.placesNames.value, results.count > indexPath.row, results[indexPath.row] == .myLocation, let coordinate = MyLocationManager.shared.lastDetectedLocation?.coordinate {
            self.delegate?.addressHasBeenSelected(.init(placeName: .myLocation, coordinate: coordinate))
            self.navigationController?.popViewController(animated: true)
            return
        }
        var isMyLocationExist = 0
        if let names = viewModel.placesNames.value, names.count > 1, names[0] == .myLocation {
            isMyLocationExist = 1
        }
        if let results = viewModel.searchResult.value, results.count > indexPath.row - isMyLocationExist {
            showLoadingView()
            let place = results[indexPath.row - isMyLocationExist]
            GooglePlacesSearchManager.shared.getCoordinates(for: place) {
                result in
                if let res = result {
                    self.delegate?.addressHasBeenSelected(.init(placeName: place.attributedPrimaryText, coordinate: res.coordinate, place: res))
                    self.navigationController?.popViewController(animated: true)
                } else {
                    // handle not found
                }
                self.hideLoadingView()
            }
        }
    }
}

struct CustomPlace {
    var placeName: NSAttributedString
    var coordinate: CLLocationCoordinate2D
    var place: GMSPlace?
    
    init(placeName: NSAttributedString, coordinate: CLLocationCoordinate2D, place: GMSPlace? = nil) {
        self.placeName = placeName
        self.coordinate = coordinate
        self.place = place
    }
}
