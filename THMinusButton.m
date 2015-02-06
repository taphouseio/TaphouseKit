//
//  SBMinusButton.m
//  Scorebook
//
//  Created by Jared Sorge on 8/26/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import "THMinusButton.h"

@implementation THMinusButton

- (void)drawRect:(CGRect)rect
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat halfHeight = height /2;
    
    //// Horizontal Drawing
    UIBezierPath* horizontalPath = [UIBezierPath bezierPath];
    [horizontalPath moveToPoint: CGPointMake(self.padding, halfHeight)];
    [horizontalPath addLineToPoint: CGPointMake(width - self.padding, halfHeight)];
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
