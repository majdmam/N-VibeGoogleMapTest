//
//  AddressSearchResultTextField.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import UIKit

typealias AddressSearchResultTextFieldTag = Int

protocol AddressSearchResultTextFieldDelegate {
    func textFieldShouldBeginEditing(_ addressSearchResultTextField: AddressSearchResultTextField)
}

class AddressSearchResultTextFieldSettings {
    let placeHolder: String!
    let tag: AddressSearchResultTextFieldTag!
    
    init(placeHolder: String!, tag: AddressSearchResultTextFieldTag!) {
        self.placeHolder = placeHolder
        self.tag = tag
    }
}

class AddressSearchResultTextField: UIView {
    var delegate: AddressSearchResultTextFieldDelegate?
    private(set) var viewTag: AddressSearchResultTextFieldTag = 0 {
        didSet {
            tag = viewTag
        }
    }
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.fixedHeightConstraint(height: 48)
        tf.layer.cornerRadius = 12
        tf.layer.borderColor = UIColor.secondaryLabel.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let stack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .equalSpacing
        s.alignment = .fill
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(stack)
        stack.pinEdges(to: self)
        
        textField.delegate = self
        stack.addArrangedSubview(textField)
    }
    
    func setup(settings: AddressSearchResultTextFieldSettings) {
        textField.placeholder = settings.placeHolder
        
        viewTag = settings.tag
    }
}

extension AddressSearchResultTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldBeginEditing(self)
        return false
    }
}
