//
//  THPlusButton.h
//  TaphouseKit
//
//  Created by Jared Sorge on 8/17/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THPlusButton : UIButton
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;
@property (nonatomic) IBInspectable CGFloat strokeWidth;
@property (nonatomic) IBInspectable CGFloat padding;
@end
