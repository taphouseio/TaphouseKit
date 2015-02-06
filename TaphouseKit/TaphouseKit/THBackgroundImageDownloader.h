//
//  THBackgroundImageDownloader.h
//  TaphouseKit
//
//  Created by Jared Sorge on 8/5/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THBackgroundImageDownloader : NSObject
/**
 *  Asynchronously downloads a given image. It's returned in the completion block.
 *
 *  @param url             URL of the image to be downloaded
 *  @param completionBlock What to do with the image when it is finished downloading
 */
+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSData *data))completionBlock;
@end
