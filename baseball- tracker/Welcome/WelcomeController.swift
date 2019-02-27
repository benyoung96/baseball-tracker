//
//  SwippingController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/26/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

class WelcomeController: UICollectionViewController {
    weak var coordinator: MainCoordiantor?
    private let welcomeView = WelcomeView()
    private var currentPage: Int?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViews()
    }
}

// MARK: - Private Methods
extension WelcomeController {
    
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
    
    fileprivate func setupViews() {
        view.addSubview(welcomeView)
        view.addConstraints([
            welcomeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - ControllerType Methods
extension WelcomeController: ControllerType {
    
    static func create() -> UIViewController {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let vc = WelcomeController(collectionViewLayout: layout)
        return vc
    }
}

// MARK: - Target Actions
extension WelcomeController {
    
    @objc func next(_ sender: UIButton) {
        if welcomeView.pageControl.currentPage == 2 || currentPage == 2 {
            coordinator?.popWelcome()
        }
        let nextIndex = min(welcomeView.pageControl.currentPage + 1, 2)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        welcomeView.pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func previous(_ sender: UIButton) {
        print(welcomeView.pageControl.currentPage)
        let previousIndex = max(welcomeView.pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        welcomeView.pageControl.currentPage = previousIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UIScrollView Methods
extension WelcomeController {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x / view.frame.width
        currentPage = Int(x)
        welcomeView.pageControl.currentPage = Int(x)
    }
}

// MARK: - UICollectionViewDataSource Methods
extension WelcomeController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as WelcomeCell
        
        if indexPath.item == 0 {
            cell.titleLabel.text = "Baseball Tracker"
            cell.descriptionLabel.text = "Keep track of batting, pitching and defence statistics throughout the regular season."
        }
        if indexPath.item == 1 {
            cell.titleLabel.text = "Line Ups/Rotations"
            cell.descriptionLabel.text = "Setup your everyday line up and starting rotations. Make changes if a player is traded or injuried"
        }
        if indexPath.item == 2 {
            cell.titleLabel.text = "Browse Stats"
            cell.descriptionLabel.text = "Browse cumulative statistics of position players and pitchers that you have tracked"
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension WelcomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
