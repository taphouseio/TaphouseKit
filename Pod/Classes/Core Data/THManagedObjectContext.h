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
 *  @param modelName         The name of the managed object model
 *  @param concurrencyType   The concurrency type for the context
 *
 *  @return THManagedObjectContext
 */
+ (instancetype)createContextWithModelName:(NSString *)modelName concurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType;
@end
