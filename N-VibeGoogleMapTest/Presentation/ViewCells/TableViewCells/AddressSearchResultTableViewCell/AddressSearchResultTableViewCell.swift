//
//  AddressSearchResultTableViewCell.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import UIKit
import GooglePlaces

extension TableViewCells {
    static let addressSearchResultTableViewCell = "AddressSearchResultTableViewCell"
}

class AddressSearchResultTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.pinEdges(to: self, constant: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print(selected)
    }
    
    func config(model: NSAttributedString) {
        self.titleLabel.attributedText = model
    }
}
