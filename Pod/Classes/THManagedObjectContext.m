//
//  THManagedObjectContext.m
//  TaphouseKit
//
//  Created by Jared Sorge on 3/25/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import "THManagedObjectContext.h"

NSString *const ContextNeedsUIUpdateNotification = @"contextNeedsUIUpdate";

@implementation THManagedObjectContext
#pragma mark - API
+ (instancetype)createContextWithStoreURL:(NSURL *)storeURL modelName:(NSString *)modelName
{
    NSMutableArray *models = [NSMutableArray array];
    NSManagedObjectModel *firstModel = [self loadManagedObjectModelNamed:modelName];
    [models addObject:firstModel];
    
    NSManagedObjectModel *finalModel = [NSManagedObjectModel modelByMergingModels:models];
    NSAssert(finalModel != nil, @"Could not laod MOM");
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc ]initWithManagedObjectModel:finalModel];
    NSError *error;
    NSString *storeType = NSSQLiteStoreType;
    NSMutableDictionary *options = [@{NSMigratePersistentStoresAutomaticallyOption : @YES,
                                      NSInferMappingModelAutomaticallyOption : @YES} mutableCopy];
    
    if (![coordinator addPersistentStoreWithType:storeType
                                   configuration:nil
                                             URL:storeURL
                                         options:options
                                           error:&error]) {
        //TODO: Handle error better
        NSLog(@"Failed creating persistent store with error: %@", error);
        abort();
    }
    
    THManagedObjectContext *context = [[self alloc] initWithPersistentStoreCoordinator:coordinator];
    
    return context;
}

+ (BOOL)storeNeedsMigrationAtURL:(NSURL *)storeURL modelName:(NSString *)modelName;
{
    BOOL compatible = NO;
    NSError *error;
    
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:nil
                                                                                              URL:storeURL
                                                                                            error:&error];
    if (error) {
        //TODO: Handle error
        abort();
    } else if (sourceMetadata != nil) {
        NSManagedObjectModel *destinationModel = [self loadManagedObjectModelNamed:modelName];
        compatible = [destinationModel isConfiguration:nil
                           compatibleWithStoreMetadata:sourceMetadata];
    }
    
    return !compatible;
}

+ (NSURL *)storeURL
{
    [NSException raise:@"THException" format:@"This method must be overridden by a subclass."];
    return nil;
}

#pragma mark - Private
- (instancetype)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)coordinator
{
    self = [super initWithConcurrencyType:NSMainQueueConcurrencyType];
    if (self) {
        self.persistentStoreCoordinator = coordinator;
    }
    return self;
}

+ (NSManagedObjectModel *)loadManagedObjectModelNamed:(NSString *)modelName
{
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:bundleURL];
}
@end
