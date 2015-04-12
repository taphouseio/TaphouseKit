//
//  THBackgroundImageDownloader.m
//  TaphouseKit
//
//  Created by Jared Sorge on 8/5/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import "THBackgroundImageDownloader.h"

@implementation THBackgroundImageDownloader
+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSData *data))completionBlock
{
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                 if (error) {
                                                                     completionBlock(NO, nil);
                                                                 } else {
                                                                     completionBlock(YES, data);
                                                                 }
                                                             }];
                                                         }];
    [task resume];
}
@end
