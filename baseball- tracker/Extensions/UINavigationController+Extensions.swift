//
//  UINavigationController+Extensions.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/25/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initRootController(vc: UIViewController) {
        viewControllers.removeAll()
        pushViewController(vc, animated: false)
    }
    
    func style() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .welcomeBackground
        navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBar.titleTextAttributes = textAttributes
    }
}
