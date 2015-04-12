//
//  THBackgroundImageDownloader.h
//  TaphouseKit
//
//  Created by Jared Sorge on 8/5/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DownloadCompletionBlock)(BOOL succeeded, NSData *data);

@interface THBackgroundImageDownloader : NSObject
/**
 *  Asynchronously downloads a given image. It's returned in the completion block. Both parameters must not be nil. If either are nil, an assertion failure will occur.
 *
 *  @param url             URL of the image to be downloaded
 *  @param completionBlock What to do with the image when it is finished downloading
 *
 *  @return A configured instance of the downloader class. Use the -startDownload method to use it.
 */
- (instancetype)initWithURL:(NSURL *)url completionBlock:(DownloadCompletionBlock)completionBlock;

/**
 *  Runs the image downloader, and calls the completion block when finished.
 */
- (void)startDownload;
@end
