//
//  UICollectionView+Extenion.swift
//  GitCrop
//
//  Created by dev dfcc on 7/30/24.
//

import UIKit

extension UICollectionView: Reusable {
    func registerCell<Cell: UICollectionViewCell>(_: Cell.Type) {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueCell<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        return self.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}
