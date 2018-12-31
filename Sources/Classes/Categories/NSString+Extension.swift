//
//  NSString+Extension.swift
//  Scorebook
//
//  Created by Jared Sorge on 12/31/18.
//  Copyright © 2018 Taphouse Software LLC. All rights reserved.
//

import Foundation

extension NSString {
    @objc(th_isEmpty)
    public var isEmpty: Bool {
        return (self as String).isEmpty
    }
}
