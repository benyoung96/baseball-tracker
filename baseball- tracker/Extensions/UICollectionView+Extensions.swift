//
//  UICollectionView+Extensions.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/26/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell  else {
            fatalError("Fatal error for cell at \(indexPath)")
        }
        
        return cell
    }
}
