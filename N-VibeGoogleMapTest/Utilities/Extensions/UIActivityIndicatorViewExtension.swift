//
//  File.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import UIKit

extension UIActivityIndicatorView {
    
    static func makeDefault(dimentions: CGFloat = 50) -> UIView {
        let indicator = CustomLoadingIndicator.getCustomLoadingIndicatorAsView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: indicator, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: dimentions)
        let heightConstraint = NSLayoutConstraint(item: indicator, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: dimentions)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        //indicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return indicator
    }
}
