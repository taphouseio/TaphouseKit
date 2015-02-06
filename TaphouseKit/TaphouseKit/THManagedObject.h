//
//  THManagedObject.h
//  TaphouseKit
//
//  Created by Jared Sorge on 3/25/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

@import Foundation;
@import CoreData;
@class THManagedObjectContext;

@interface THManagedObject : NSManagedObject

#pragma mark - API
/**
 *  Used to create a new instance of the managed object in a given context
 *
 *  @param context The context to create the managed object in.
 *
 *  @return instancetype
 */
+ (instancetype)newInstanceInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  Useful to get the name of the entity without having to use stringly-typed calls
 *
 *  @return NSString of the subclass
 */
+ (NSString *)entityName;

/**
 *  Creates a new fetch request for the entity
 *
 *  @return NSFetchRequest
 */
+ (NSFetchRequest *)fetchRequest;

/**
 *  Performs a fetch for all instances of the class with the predicate
 *
 *  @param predicate What to search for
 *  @param context   The context to search in
 *
 *  @return An array of results
 */
+ (NSArray *)allInstancesWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

/**
 *  All instances of the class in the given context
 *
 *  @param context The context to search
 *
 *  @return An array of reuslts
 */
+ (NSArray *)allInstancesInContext:(NSManagedObjectContext *)context;

/**
 *  Validates the instance of the model object. Must be overriden by a subclass if it is to be called.
 *
 *  @return YES if valid, NO if not.
 */
- (BOOL)valid;

@end
