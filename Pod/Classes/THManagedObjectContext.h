//
//  THManagedObjectContext.h
//  TaphouseKit
//
//  Created by Jared Sorge on 3/25/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

@import Foundation;
@import CoreData;

extern NSString *const ContextNeedsUIUpdateNotification;

@interface THManagedObjectContext : NSManagedObjectContext

#pragma mark - API
/**
 *  Creates a new managed object context for use on the main queue.
 *
 *  @param storeURL          The location on disk where the store is to be kept.
 *  @param modelName         The name of the managed object model
 *
 *  @return SBManagedObjectContext
 */
+ (instancetype)createContextWithStoreURL:(NSURL *)storeURL modelName:(NSString *)modelName;

/**
 *  Checks to see if the managed object model at the given URL matches what is in the app bundle's managed object model.
 *
 *  @param storeURL The location of the persistent store.
 *
 *  @return YES if migration needs to happen, NO if not.
 */
+ (BOOL)storeNeedsMigrationAtURL:(NSURL *)storeURL modelName:(NSString *)modelName;

/**
 *  This method must be overridden by a subclass. Do not call super.
 *
 *  @return The URL where the datastore is to be kept.
 */
+ (NSURL *)storeURL;
@end
