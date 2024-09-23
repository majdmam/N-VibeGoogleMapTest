//
//  UIImageExtension.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import UIKit

extension UIImage {
    
    static func from(_ name: Constants.Images) -> UIImage? {
        return UIImage(named: name.rawValue)
    }
    
    static func from(_ name: Constants.Images, with renderingMode: UIImage.RenderingMode) -> UIImage? {
        return UIImage(named: name.rawValue)?.withRenderingMode(renderingMode)
    }
    
    static func from(_ name: Constants.Images, color: UIColor) -> UIImage? {
        return UIImage(named: name.rawValue)?.withTintColor(color, renderingMode: .alwaysTemplate)
    }
}
