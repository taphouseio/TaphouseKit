//
//  THBackgroundImageDownloader.m
//  TaphouseKit
//
//  Created by Jared Sorge on 8/5/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import "THBackgroundImageDownloader.h"

@interface THBackgroundImageDownloader ()
@property (nonatomic, copy)DownloadCompletionBlock completionBlock;
@property (nonatomic, strong)NSURL *url;
@end

@implementation THBackgroundImageDownloader
- (instancetype)initWithURL:(NSURL *)url completionBlock:(DownloadCompletionBlock)completionBlock
{
    NSAssert(url != nil, @"There must be a URL submitted to the background image downloader class.");
    NSAssert(completionBlock != nil, @"There must be a completion block submitted to the background image downloader class.");
    
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
        self.url = url;
    }
    return self;
}

- (void)startDownload
{
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.url
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                 typeof(weakSelf) strongSelf = weakSelf;
                                                                 if (error) {
                                                                     strongSelf.completionBlock(NO, nil);
                                                                 } else {
                                                                     strongSelf.completionBlock(YES, data);
                                                                 }
                                                             }];
                                                         }];
    [task resume];
}
@end
