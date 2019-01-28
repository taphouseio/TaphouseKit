//
//  Storyboardinitializable.swift
//  TaphouseKit
//
//  Created by Jared Sorge on 7/10/17.
//  Copyright © 2017 Taphouse Software. All rights reserved.
//

import UIKit

public protocol StoryboardInitializable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    static var storyboardIdentifier: String { get }
    
    static func makeFromStoryboard() -> Self
}

extension StoryboardInitializable where Self : UIViewController {
    public static var storyboardName: String {
        return "Main"
    }
    
    public static var storyboardBundle: Bundle? {
        return nil
    }
    
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    public static func makeFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(
            withIdentifier: storyboardIdentifier) as! Self
    }
}
