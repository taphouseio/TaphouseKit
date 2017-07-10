//
//  Storyboardinitializable.swift
//  TaphouseKit
//
//  Created by Jared Sorge on 7/10/17.
//  Copyright © 2017 Taphouse Software. All rights reserved.
//

import UIKit

@objc public protocol StoryboardInitializable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    
    static func makeFromStoryboard() -> UIViewController
}

public extension StoryboardInitializable where Self : UIViewController {
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardBundle: Bundle? {
        return nil
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func makeFromStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(
            withIdentifier: storyboardIdentifier) as! Self
    }
}
