//
//  UIView+Extensions.swift
//  baseball- tracker
//
//  Created by Ben Young on 2/22/19.
//  Copyright © 2019 Ben Young. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Define the constraints for a view that will be positions in the center of the view
    /// controller with a width the size of the device's screen. If safe area guides are
    /// available they will be used
    ///
    /// - Parameter parentView: parent view of the view being constrained
    public func safeAreaFullScreen(to parentView: UIView) {
        if #available(iOS 11.0, *) {
            leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
            topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
            topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        }
    }
    
}
