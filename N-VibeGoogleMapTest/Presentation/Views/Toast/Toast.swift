//
//  Toast.swift
//
//  Created by Applications Team on 1/21/23.
//

import UIKit

class Toast: UIView  {
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 100
        return label
    }()
    let icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    static var isShowingNow = false
    
    var toast: ToastModel? {
        didSet {
            setupToast()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        addSubview(icon)
        icon.centerToLeading(in: self, leadingConstant: 10, width: 22, height: 22)
        title.fillAndLeading(to: icon.trailingAnchor, in: self, leadingConstant: 12, constant: 12)
    }
    
    func configureInside(container: UIView) {
        container.addSubview(self)
        self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20).isActive = true
        self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20).isActive = true
        let keyboardHeight: CGFloat = 60
        self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -(keyboardHeight)).isActive = true
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
    }
    
    func setupToast() {
        if let t = toast {
            self.title.textColor = t.toastStyle.textColor
//            self.title.font = .appRegularFont(14)
            self.title.text = t.message
            self.icon.image = UIImage.from(t.icon, color: t.toastStyle.tintColor)
            self.icon.tintColor = t.toastStyle.tintColor
            self.backgroundColor = t.toastStyle.backColor
            self.backgroundColor = t.toastStyle.backColor
            self.layer.cornerRadius = 10
            self.layer.cornerRadius = 10
        }
    }
}

class ToastStyle {
    var backColor: UIColor
    var textColor: UIColor
    var tintColor: UIColor
    
    init(backColor: UIColor, textColor: UIColor, tintColor: UIColor) {
        self.backColor = backColor
        self.textColor = textColor
        self.tintColor = tintColor
    }
}

class ToastModel {
    private var styles: [ToastStyle] = [ToastStyle(backColor: .init(hex: 0xFED5DA), textColor: .init(hex: 0x7C1021), tintColor: UIColor(hex: 0x7C1021)), ToastStyle(backColor: .init(hex: 0xCEEED9), textColor: .init(hex: 0x155724), tintColor: .init(hex: 0x155724)), ToastStyle(backColor: UIColor(hex: 0xFFF2CC), textColor: UIColor(hex: 0xFFCC00), tintColor: UIColor(hex: 0xFFCC00))]
    
    var message: String
    var icon: Constants.Images
    var toastStyle: ToastStyle
    
    init(message: String, icon: Constants.Images, toastStyle: ToastStyle) {
        self.message = message
        self.icon = icon
        self.toastStyle = toastStyle
    }
    
    init(message: String, icon: Constants.Images, toastStyle: ToastStyles) {
        self.message = message
        self.icon = icon
        self.toastStyle = styles[toastStyle.rawValue]
    }
    
    init(message: String, icon: Constants.Images, backColor: UIColor, textColor: UIColor, tintColor: UIColor) {
        self.message = message
        self.icon = icon
        self.toastStyle = ToastStyle(backColor: backColor, textColor: textColor, tintColor: tintColor)
    }
}

enum ToastStyles: Int {
    case error = 0
    case success = 1
    case warning = 2
}
