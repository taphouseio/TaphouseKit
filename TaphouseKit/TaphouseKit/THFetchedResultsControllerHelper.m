//
//  THFetchedResultsControllerHelper.m
//  TaphouseKit
//
//  Created by Jared Sorge on 7/26/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import "THFetchedResultsControllerHelper.h"

@interface THFetchedResultsControllerHelper ()
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *collectionViewObjectChanges;
@end

@implementation THFetchedResultsControllerHelper
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (self.tableView) {
        [self.tableView beginUpdates];
    } else if (self.collectionView) {
        self.collectionViewObjectChanges = [NSMutableArray new];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (self.tableView) {
        [self.tableView endUpdates];
    } else if (self.collectionView) {
        if (self.collectionViewObjectChanges.count > 0) {
            [self.collectionView performBatchUpdates:^{
                for (NSDictionary *objectChange in self.collectionViewObjectChanges) {
                    [objectChange enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                        NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                        
                        switch (type) {
                            case NSFetchedResultsChangeInsert:
                                [self.collectionView insertItemsAtIndexPaths:@[obj]];
                                break;
                                
                            case NSFetchedResultsChangeUpdate:
                                [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                                break;
                                
                            case NSFetchedResultsChangeDelete:
                                [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                                break;
                            
                            case NSFetchedResultsChangeMove:
                                break;
                        }
                    }];
                }
            } completion:nil];
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            if (self.tableView) {
                if ([self tableViewHasFewerSectionsThanNeeded]) {
                    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (self.collectionView) {
                [self.collectionViewObjectChanges addObject:@{@(type): newIndexPath}];
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            if (self.tableView) {
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (self.collectionView) {
                [self.collectionViewObjectChanges addObject:@{@(type): indexPath}];
            }
            break;
        
        case NSFetchedResultsChangeDelete:
            if (self.tableView) {
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                if ([self tableViewHasMoreSectionsThanNeeded]) {
                    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            } else if (self.collectionView) {
                [self.collectionViewObjectChanges addObject:@{@(type): indexPath}];
            }
            break;
        
        case NSFetchedResultsChangeMove:
            if (self.tableView) {
                [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            } else if (self.collectionView) {
                [self.collectionViewObjectChanges addObject:@{@(type): @[indexPath, newIndexPath]}];
            }
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    if (self.tableView) {
        
    } else if (self.collectionView) {
        
    }
}

#pragma mark - Private
- (BOOL)tableViewHasFewerSectionsThanNeeded
{
    NSInteger currentNumberOfSections = [self.tableView numberOfSections];
    NSInteger neededNumberOfSections = [self.tableView.dataSource numberOfSectionsInTableView:self.tableView];

    return neededNumberOfSections > currentNumberOfSections;
}

- (BOOL)tableViewHasMoreSectionsThanNeeded
{
    NSInteger currentNumberOfSections = [self.tableView numberOfSections];
    NSInteger neededNumberOfSections = [self.tableView.dataSource numberOfSectionsInTableView:self.tableView];
    
    return neededNumberOfSections < currentNumberOfSections;
}

@end
