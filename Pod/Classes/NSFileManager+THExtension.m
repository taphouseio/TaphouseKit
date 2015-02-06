//
//  NSFileManager+extension.m
//  TaphouseKit
//
//  Created by Jared Sorge on 6/9/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import "NSFileManager+THExtension.h"

@implementation NSFileManager (THExtension)
+ (NSString *)th_documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}
@end