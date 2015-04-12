//
//  NSDate+extension.m
//  TaphouseKit
//
//  Created by Jared Sorge on 9/1/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import "NSDate+extension.h"

@implementation NSDate (extension)
+ (NSDate *)monthAndYearFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
    
    return [calendar dateFromComponents:components];
}
@end
