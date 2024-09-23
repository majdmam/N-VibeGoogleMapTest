//
//  UIViewExtensions.swift
//  N-VibeTest
//
//  Created by Applications Team on 9/22/24.
//

import UIKit

extension UIView {
    func pinEdges(to parent: UIView, constant: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -constant).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -constant).isActive = true
    }
    
    func pinSidesAndTop(to parent: UILayoutGuide, constant: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -constant).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: constant).isActive = true
    }
    
    func fixedHeightConstraint(height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func center(in parent: UIView, width: CGFloat? = nil, height: CGFloat? = nil) {
        parent.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        if let w = width {
            self.widthAnchor.constraint(equalToConstant: w).isActive = true
        }
        if let h = height {
            self.heightAnchor.constraint(equalToConstant: h).isActive = true
        }
    }
    
    func centerToTrailing(in parent: UIView, trailingConstant: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        parent.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: trailingConstant).isActive = true
        centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        if let w = width {
            self.widthAnchor.constraint(equalToConstant: w).isActive = true
        }
        if let h = height {
            self.heightAnchor.constraint(equalToConstant: h).isActive = true
        }
    }
    
    func centerToLeading(in parent: UIView, leadingConstant: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        parent.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: leadingConstant).isActive = true
        centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        if let w = width {
            self.widthAnchor.constraint(equalToConstant: w).isActive = true
        }
        if let h = height {
            self.heightAnchor.constraint(equalToConstant: h).isActive = true
        }
    }
    
    func fillAndTrailing(to targetViewAnchor: NSLayoutXAxisAnchor, in parent: UIView, trailingConstant: CGFloat = 0, constant: CGFloat = 0) {
        parent.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: targetViewAnchor, constant: trailingConstant).isActive = true
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: constant).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -constant).isActive = true
    }
    
    func fillAndLeading(to targetViewAnchor: NSLayoutXAxisAnchor, in parent: UIView, leadingConstant: CGFloat = 0, constant: CGFloat = 0) {
        parent.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: targetViewAnchor, constant: leadingConstant).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -constant).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -constant).isActive = true
    }
    
    static func makeDefaultLoadingView(_ backgroundAlpha: CGFloat = 0.8) -> UIView {
        let indicator = UIActivityIndicatorView.makeDefault()
        let indicatorView = UIView()
        let indicatorBackground = UIView()
        indicatorBackground.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.addSubview(indicatorBackground)
        indicatorView.addSubview(indicator)
        indicatorView.backgroundColor = .clear
        indicatorBackground.alpha = backgroundAlpha
        indicatorBackground.pinEdges(to: indicatorView)
        indicatorView.isHidden = true
        indicatorBackground.backgroundColor = .secondarySystemBackground
        indicator.center(in: indicatorView)
        return indicatorView
    }
}
