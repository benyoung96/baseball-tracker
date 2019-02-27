//
//  OnBoardingController.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit
import CoreData

class SetupController: UIPageViewController {
    weak var coordinator: MainCoordiantor?
    var pages: [UIViewController]?
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setupControllers()
    }
}

// MARK: - Private Methods
extension SetupController {
    
    fileprivate func setupControllers() {
        if let firstVC = pages?.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: - ControllerType Methods
extension SetupController: ControllerType {
    
    static func create() -> UIViewController {
        let vc = SetupController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return vc
    }
}

// MARK: - UIPageViewControllerDelegate
extension SetupController: UIPageViewControllerDelegate {
    
}

// MARK: - UIPageViewControllerDataSource
extension SetupController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages?.firstIndex(of: viewController) else {
            fatalError("Failed to get index of current view controller")
        }
        let previousIndex = index - 1
        guard previousIndex >= 0 else { return pages?.last }
        guard (pages?.count)! > previousIndex else {
            fatalError("Failed to get correct index of view controller")
        }
        return pages?[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages?.firstIndex(of: viewController) else {
            fatalError("Failed to get index of current view controller")
        }
        let nextIndex = index + 1
        guard nextIndex < (pages?.count)! else {
            return pages?.first
        }
        guard (pages?.count)! > nextIndex else {
            return nil
        }
        return pages?[nextIndex]
    }
}
