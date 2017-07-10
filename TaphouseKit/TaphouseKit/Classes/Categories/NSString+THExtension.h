//
//  NSString+Extension.h
//  TaphouseKit
//
//  Created by Jared Sorge on 3/10/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  URL Encodes a given string. Got this code from http://madebymany.com/blog/url-encoding-an-nsstring-on-ios
 *
 *  @param encoding The encoding of the resulting string.
 *
 *  @return A URL-encoded string using the sent in encodeing
 */
-(NSString *)th_urlEncodeUsingEncoding:(NSStringEncoding)encoding;
@end
