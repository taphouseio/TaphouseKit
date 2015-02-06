//
//  NSFileManager+extension.h
//  TaphouseKit
//
//  Created by Jared Sorge on 6/9/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (extension)
/**
 *  File path to the documents directory
 *
 *  @return Documents directory path
 */
+ (NSString *)th_documentsPath;
@end
