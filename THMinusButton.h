//
//  SBMinusButton.h
//  Scorebook
//
//  Created by Jared Sorge on 8/26/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface THMinusButton : UIButton
@property (nonatomic, strong) IBInspectable UIColor *strokeColor;
@property (nonatomic) IBInspectable CGFloat strokeWidth;
@property (nonatomic) IBInspectable CGFloat padding;
@end
