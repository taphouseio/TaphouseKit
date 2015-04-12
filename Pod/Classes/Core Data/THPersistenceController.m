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
+ (instancetype)createGlobalPersistenceControllerWithModelName:(NSString *)modelName storeURL:(NSURL *)storeURL storeType:(NSString *)storeType callback:(InitCallbackBlock)callback;
{
    if (_globalPersistenceController != nil) {
        return [THPersistenceController globalPersistenceController];
    }
    
    _globalPersistenceController = [[THPersistenceController alloc] initWithStoreType:storeType
                                                                            modelName:modelName
                                                                             storeURL:storeURL
                                                                             callback:callback];
    return _globalPersistenceController;
}

+ (instancetype)globalPersistenceController
{
    NSAssert(_globalPersistenceController != nil, @"The global persistence controller must not be nil before usage.");
    return _globalPersistenceController;
}

- (void)save
{
    if (![self.privateContext hasChanges] && ![self.masterContext hasChanges]) {
        return;
    }
    
    [self.masterContext performBlockAndWait:^{
        NSError *saveError = nil;
        [self.masterContext save:&saveError];
        NSAssert(saveError == nil, @"Failed to save on the main thread: %@\n%@", saveError.localizedDescription, saveError.userInfo);
        
        [self.privateContext performBlock:^{
            NSError *privateError = nil;
            [self.privateContext save:&privateError];
            NSAssert(privateError == nil, @"Failed to save on the private thread.", privateError.localizedDescription, privateError.userInfo);
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
- (instancetype)initWithStoreType:(NSString *)storeType modelName:(NSString *)modelName storeURL:(NSURL *)storeURL callback:(InitCallbackBlock)callback
{
    self = [super init];
    
    if (self) {
        self.callbackBlock = callback;
        [self setupCoreDataWithStoreType:storeType modelName:modelName storeURL:storeURL];
    }
    
    return self;
}

- (void)setupCoreDataWithStoreType:(NSString *)storeType modelName:(NSString *)modelName storeURL:(NSURL *)storeURL
{
    if (self.masterContext) {
        return;
    }
    
    self.masterContext = [THManagedObjectContext createContextWithModelName:modelName
                                                            concurrencyType:NSMainQueueConcurrencyType];
    
    self.privateContext = [[THManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
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
                                                 URL:storeURL
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
