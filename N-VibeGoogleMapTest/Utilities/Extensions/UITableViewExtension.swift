//
//  UITableViewExtension.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import UIKit

typealias TableViewCells = String

extension UITableView {
    func dequeueReusableCell(withReuseIdentifier identifier: TableViewCells, for indexPath: IndexPath) -> UITableViewCell? {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func register(name: TableViewCells) {
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}
