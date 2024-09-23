//
//  CustomLoadingIndicator.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import Lottie
import SwiftUI

class CustomLoadingIndicator: UIView {
    
    private var indicator: LottieAnimationView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator = .init(name: "indicator")
        indicator!.frame = self.bounds
        indicator!.bounds = self.bounds
        indicator!.contentMode = .scaleAspectFill
        indicator!.loopMode = .loop
        indicator!.animationSpeed = 1
        addSubview(indicator!)
        indicator!.play()
    }
}

extension CustomLoadingIndicator {
    static func getCustomLoadingIndicatorAsView() -> UIView {
        let view = UIView()
        let indicator = LottieAnimationView(name: "indicator")
        view.translatesAutoresizingMaskIntoConstraints = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.contentMode = .scaleAspectFill
        indicator.loopMode = .loop
        indicator.animationSpeed = 1
        view.addSubview(indicator)
        indicator.play()
        indicator.pinEdges(to: view)
        return view
    }
    
    static func loadMoreIndicator() -> UIView {
        let view = UIView()
        let widthConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        let indicator = LottieAnimationView(name: "indicator")
        indicator.contentMode = .scaleAspectFill
        indicator.loopMode = .loop
        indicator.animationSpeed = 1
        view.addSubview(indicator)
        indicator.play()
        indicator.pinEdges(to: view)
        return view
    }
}
