//
//  Reusable.swift
//  GitCrop
//
//  Created by dev dfcc on 7/30/24.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }

    static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
