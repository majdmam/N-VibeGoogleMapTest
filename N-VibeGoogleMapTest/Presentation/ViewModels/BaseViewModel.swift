//
//  BaseViewModel.swift
//  N-VibeGoogleMapTest
//
//  Created by Applications Team on 9/23/24.
//

import Foundation

class BaseViewModel {
    var loading: Box<Bool> = Box(false)
}

class Box<T> {

    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }

    init( _ value: T?) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
