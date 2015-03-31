//
//  THPersistenceController.m
//  Pods
//
//  Created by Jared Sorge on 3/31/15.
//  Copyright (c) 2015 Taphouse Software. All rights reserved.
//

#import "THPersistenceController.h"
#import "THManagedObjectContext.h"

@interface THPersistenceController ()
@property (nonatomic, readwrite) NSManagedObjectContext *masterContext;
@property (nonatomic, strong) NSManagedObjectContext *privateContext;
@property (nonatomic, copy) InitCallbackBlock callbackBlock;
@end

static THPersistenceController *_globalPersistenceController = nil;

@implementation THPersistenceController
#pragma mark - API
+ (instancetype)createGlobalPersistenceControllerWithCallback:(InitCallbackBlock)callback storeType:(NSString *)storeType
{
    if (_globalPersistenceController != nil) {
        return [THPersistenceController globalPersistenceController];
    }
    
    _globalPersistenceController = [[THPersistenceController alloc] initWithCallback:callback storeType:storeType];
    return _globalPersistenceController;
}

+ (instancetype)globalPersistenceController
{
    NSAssert(_globalPersistenceController != nil, @"The global persistence controller must not be nil before usage.");
    return _globalPersistenceController;
}

+ (NSURL *)storeURL
{
    [NSException raise:@"THException" format:@"This method must be overridden by a subclass."];
    return nil;
}

+ (NSString *)modelName
{
    [NSException raise:@"THException" format:@"This method must be overridden by a subclass."];
    return nil;
}

- (void)save
{
    if (![self.privateContext hasChanges] && ![self.masterContext hasChanges]) {
        return;
    }
    
    [self.masterContext performBlockAndWait:^{
        NSError *saveError = nil;
        
        NSAssert([self.masterContext save:&saveError], @"Failed to save on the main thread: %@\n%@", saveError.localizedDescription, saveError.userInfo);
        
        [self.privateContext performBlock:^{
            NSError *privateError = nil;
            NSAssert([self.privateContext save:&privateError], @"Failed to save on the private thread.", privateError.localizedDescription, privateError.userInfo);
        }];
    }];
}

#pragma mark - Private
/**
 *  Instantiates the controller. Will be called-back on the main thread once completed
 *
 *  @param callback     What should happen after instantiation
 *  @param storeType    The type of the data store. If this is nil, then it will default to NSSQLiteStoreType. Use this value if wanting a memory store type (NSInMemoryStoreType) which is useful for testing.
 *
 *  @return Ready to roll PersistenceController
 */
- (instancetype)initWithCallback:(InitCallbackBlock)callback storeType:(NSString *)storeType
{
    self = [super init];
    
    if (self) {
        self.callbackBlock = callback;
        [self setupCoreDataWithStoreType:storeType];
    }
    
    return self;
}

- (void)setupCoreDataWithStoreType:(NSString *)storeType;
{
    if (self.masterContext) {
        return;
    }
    
    self.masterContext = [THManagedObjectContext createContextWithModelName:[THPersistenceController modelName]
                                                            concurrencyType:NSMainQueueConcurrencyType];
    
    self.privateContext = [[THManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.privateContext.persistentStoreCoordinator = self.masterContext.persistentStoreCoordinator;
    self.privateContext.parentContext = self.masterContext;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSPersistentStoreCoordinator *coordinator = self.privateContext.persistentStoreCoordinator;
        NSError *error;
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @YES,
                                  NSInferMappingModelAutomaticallyOption       : @YES};
        
        NSString *persistentStoreType = storeType;
        if (persistentStoreType == nil) {
            persistentStoreType = NSSQLiteStoreType;
        }
        
        if (![coordinator addPersistentStoreWithType:persistentStoreType
                                       configuration:nil
                                                 URL:[THPersistenceController storeURL]
                                             options:options
                                               error:&error]) {
            //TODO: Handle error better
            NSLog(@"Failed creating persistent store with error: %@\n%@", error.localizedDescription, error.userInfo);
            abort();
        }
        
        if (!self.callbackBlock) {
            return;
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.callbackBlock();
        }];
    });
}
@end
