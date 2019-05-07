//
//  UINavigationController+Extensions.swift
//  TaphouseKit
//
//  Created by Jared Sorge on 7/12/17.
//  Copyright © 2017 Taphouse Software. All rights reserved.
//

import UIKit

extension UINavigationController {
    /// If the navigation controller just popped a view controller, this method returns it.
    /// This is helpful when wanting to know what just happened when using a `UINavigationControllerDelegate`.
    /// Got the idea from http://khanlou.com/2017/05/back-buttons-and-coordinators/
    public func poppedViewController() -> UIViewController? {
        guard
            let fromViewController = transitionCoordinator?.viewController(forKey: .from),
            viewControllers.contains(fromViewController) == false else {
                return nil
        }
        
        return fromViewController
    }
}
