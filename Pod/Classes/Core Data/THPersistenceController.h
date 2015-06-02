//
//  THPersistenceController.h
//  Pods
//
//  Created by Jared Sorge on 3/31/15.
//  Copyright (c) 2015 Taphouse Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;

typedef void (^InitCallbackBlock)(void);

@interface THPersistenceController : NSObject
@property (nonatomic, readonly) NSManagedObjectContext *masterContext;

#pragma mark - API
/**
 *   Instantiates the global persistence controller to be used through the application. Call this only once.
 *
 *  @param callback     What should happen after instantiation
 *  @param storeType    The type of the data store. If this is nil, then it will default to NSSQLiteStoreType. Use this value if wanting a memory store type (NSInMemoryStoreType) which is useful for testing.
 *
 *  @return An instance of the global persistence controller for usage
 */
+ (instancetype)createGlobalPersistenceControllerWithModelName:(NSString *)modelName storeURL:(NSURL *)storeURL storeType:(NSString *)storeType callback:(InitCallbackBlock)callback;

/**
 *  Returns the global persistence controller. This must not be called before configuring with the +createGlobalPersistenceControllerWithCallback:storeType method
 *
 *  @return The controller class to manage all the data persistence
 */
+ (instancetype)globalPersistenceController;

/**
 *  Performs a save on a background thread
 */
- (void)save;
@end
