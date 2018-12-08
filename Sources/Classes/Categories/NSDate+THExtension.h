//
//  NSDate+extension.h
//  TaphouseKit
//
//  Created by Jared Sorge on 9/1/14.
//  Copyright (c) 2014 Taphouse Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (extension)
/**
 *  Parses the month and year from a given date. Useful when normalizing many dates that take place in a given month
 *
 *  @param date The date to parse
 *
 *  @return A date that is normalized to the first day of that date's month
 */
+ (NSDate *)th_monthAndYearFromDate:(NSDate *)date;
@end
