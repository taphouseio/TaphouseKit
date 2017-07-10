//
//  NSString+Extension.m
//  Pods
//
//  Created by Jared Sorge on 3/10/15.
//
//

#import "NSString+THExtension.h"

@implementation NSString (Extension)
-(NSString *)th_urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end
