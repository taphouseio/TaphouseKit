//
//  SBGearButton.m
//  Scorebook
//
//  Created by Jared Sorge on 9/9/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import "THGearButton.h"

@implementation THGearButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// Inner Circle Drawing
    UIBezierPath* innerCirclePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(6.5, 6.5, 7, 7)];
    [[self preferredStrokeColor] setStroke];
    innerCirclePath.lineWidth = 1;
    [innerCirclePath stroke];
    
    
    //// Gear Outline Drawing
    UIBezierPath* gearOutlinePath = [UIBezierPath bezierPath];
    [gearOutlinePath moveToPoint: CGPointMake(6.48, 4.02)];
    [gearOutlinePath addLineToPoint: CGPointMake(8.31, 3.26)];
    [gearOutlinePath addLineToPoint: CGPointMake(8.62, 0.5)];
    [gearOutlinePath addLineToPoint: CGPointMake(11.53, 0.5)];
    [gearOutlinePath addLineToPoint: CGPointMake(11.53, 3.56)];
    [gearOutlinePath addLineToPoint: CGPointMake(13.52, 4.33)];
    [gearOutlinePath addLineToPoint: CGPointMake(15.82, 2.65)];
    [gearOutlinePath addLineToPoint: CGPointMake(17.66, 4.33)];
    [gearOutlinePath addLineToPoint: CGPointMake(15.52, 6.63)];
    [gearOutlinePath addLineToPoint: CGPointMake(16.59, 8.77)];
    [gearOutlinePath addLineToPoint: CGPointMake(19.5, 8.93)];
    [gearOutlinePath addLineToPoint: CGPointMake(19.5, 11.53)];
    [gearOutlinePath addLineToPoint: CGPointMake(16.44, 11.69)];
    [gearOutlinePath addLineToPoint: CGPointMake(15.67, 13.68)];
    [gearOutlinePath addLineToPoint: CGPointMake(17.66, 16.13)];
    [gearOutlinePath addLineToPoint: CGPointMake(15.67, 17.81)];
    [gearOutlinePath addLineToPoint: CGPointMake(13.37, 15.67)];
    [gearOutlinePath addLineToPoint: CGPointMake(11.53, 16.59)];
    [gearOutlinePath addLineToPoint: CGPointMake(11.23, 19.5)];
    [gearOutlinePath addLineToPoint: CGPointMake(8.77, 19.5)];
    [gearOutlinePath addLineToPoint: CGPointMake(8.31, 16.59)];
    [gearOutlinePath addLineToPoint: CGPointMake(6.32, 15.82)];
    [gearOutlinePath addLineToPoint: CGPointMake(4.02, 17.66)];
    [gearOutlinePath addLineToPoint: CGPointMake(2.19, 15.82)];
    [gearOutlinePath addLineToPoint: CGPointMake(4.33, 13.52)];
    [gearOutlinePath addLineToPoint: CGPointMake(3.41, 11.53)];
    [gearOutlinePath addLineToPoint: CGPointMake(0.5, 11.23)];
    [gearOutlinePath addLineToPoint: CGPointMake(0.5, 8.47)];
    [gearOutlinePath addLineToPoint: CGPointMake(3.41, 8.47)];
    [gearOutlinePath addLineToPoint: CGPointMake(4.33, 6.48)];
    [gearOutlinePath addLineToPoint: CGPointMake(2.19, 3.87)];
    [gearOutlinePath addLineToPoint: CGPointMake(4.02, 2.34)];
    [gearOutlinePath addLineToPoint: CGPointMake(6.48, 4.02)];
    [gearOutlinePath closePath];
    [[self preferredStrokeColor] setStroke];
    gearOutlinePath.lineWidth = 1;
    [gearOutlinePath stroke];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (UIColor *)strokeColor
{
    if (!_strokeColor) {
        _strokeColor = [UIColor blackColor];
    }
    return _strokeColor;
}

#pragma mark - Properties
- (NSString *)accessibilityLabel
{
    return NSLocalizedString(@"Settings", @"Settings button label");
}

#pragma mark - Private
- (UIColor *)preferredStrokeColor
{
    if (self.highlighted) {
        CGFloat hue, saturation, brightness, alpha;
        [self.strokeColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        UIColor *strokeColor = [UIColor colorWithHue:hue
                                         saturation:saturation
                                         brightness:brightness
                                              alpha:(alpha * 0.25)];
        
        return strokeColor;
    }
    
    return self.strokeColor;
}

@end
