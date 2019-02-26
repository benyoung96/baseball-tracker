//
//  SwippingController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/26/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class SwippingController: UICollectionViewController {
    weak var coordinator: MainCoordiantor?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

// MARK: - Private Methods
extension SwippingController {
    
    fileprivate func setupCollectionView() {
        collectionView.register(WelcomeCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }
}

// MARK: - ControllerType Methods
extension SwippingController: ControllerType {
    
    static func create() -> UIViewController {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let vc = SwippingController(collectionViewLayout: layout)
        return vc
    }
}

// MARK: - UICollectionViewDelegate Methods
extension SwippingController {
    
    
}

// MARK: - UICollectionViewDataSource Methods
extension SwippingController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as WelcomeCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension SwippingController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
