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
+ (instancetype)createContextWithModelName:(NSString *)modelName concurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType
{
    NSMutableArray *models = [NSMutableArray array];
    NSManagedObjectModel *firstModel = [self loadManagedObjectModelNamed:modelName];
    [models addObject:firstModel];
    
    NSManagedObjectModel *finalModel = [NSManagedObjectModel modelByMergingModels:models];
    NSAssert(finalModel != nil, @"Could not laod MOM");
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc ]initWithManagedObjectModel:finalModel];
    
    THManagedObjectContext *context = [[self alloc] initWithConcurrencyType:concurrencyType];
    context.persistentStoreCoordinator = coordinator;
    
    return context;
}

#pragma mark - Private
/**
 *  Checks to see if the managed object model at the given URL matches what is in the app bundle's managed object model.
 *
 *  @param storeURL The location of the persistent store.
 *
 *  @return YES if migration needs to happen, NO if not.
 */
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
