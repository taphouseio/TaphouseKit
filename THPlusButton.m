//
//  SBPlusButton.m
//  Scorebook
//
//  Created by Jared Sorge on 8/17/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import "THPlusButton.h"

@implementation THPlusButton

- (void)drawRect:(CGRect)rect
{
    CGFloat width = self.frame.size.width;
    CGFloat height =  self.frame.size.height;
    CGFloat midHorizontal = width / 2;
    CGFloat midVertical = height / 2;
    
    //// Vertical Drawing
    UIBezierPath* verticalPath = [UIBezierPath bezierPath];
    [verticalPath moveToPoint: CGPointMake(midHorizontal, self.padding)];
    [verticalPath addLineToPoint: CGPointMake(midHorizontal, height - self.padding)];
    [[self preferredStrokeColor] setStroke];
    verticalPath.lineWidth = self.strokeWidth;
    [verticalPath stroke];
    
    
    //// Horizontal Drawing
    UIBezierPath* horizontalPath = [UIBezierPath bezierPath];
    [horizontalPath moveToPoint: CGPointMake(self.padding, midVertical)];
    [horizontalPath addLineToPoint: CGPointMake(width - self.padding, midVertical)];
    [[self preferredStrokeColor] setStroke];
    horizontalPath.lineWidth = self.strokeWidth;
    [horizontalPath stroke];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

#pragma mark - Properties
- (CGFloat)strokeWidth
{
    if (!_strokeWidth) {
        _strokeWidth = 5;
    }
    return _strokeWidth;
}

- (CGFloat)padding
{
    if (!_padding) {
        _padding = 0;
    }
    return _padding;
}

#pragma mark - Private
- (CGFloat)preferredLineWidth
{
    if (self.highlighted) {
        return self.strokeWidth + 1;
    }
    
    return self.strokeWidth;
}

- (UIColor *)preferredStrokeColor
{
    if (self.highlighted) {
        CGFloat hue, saturation, brightness, alpha;
        [self.strokeColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        return [UIColor colorWithHue:hue
                          saturation:(saturation * 0.10)
                          brightness:brightness
                               alpha:alpha];
    }
    
    return self.strokeColor;
}
@end
