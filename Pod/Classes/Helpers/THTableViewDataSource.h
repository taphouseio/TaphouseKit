//
//  THTableViewDataSource.h
//  Pods
//
//  Created by Jared Sorge on 3/6/15.
//
//

#import <Foundation/Foundation.h>
@import UIKit;
@class NSFetchedResultsController;

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface THTableViewDataSource : NSObject <UITableViewDataSource>
#pragma mark - API
/**
 *  Allows the class to be used with a table view backed by an array of objects
 *
 *  @param items       The objects to disply in the table view
 *  @param cellId      The identifier for the table view's cells
 *  @param configBlock A block that takes the cell and object for that cell to display
 *
 *  @return This datasource object
 */
- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellId configureCellBlock:(TableViewCellConfigureBlock)configBlock;

/**
 *  Sets up this class to be used with a fetched results controller. The user of this class is responsible for proper configuration and handling of the fetched results controller. This class merely accesses its results.
 *
 *  @param fetchedResultsController The Fetched Results Controller that backs the table view
 *  @param cellId      The identifier for the table view's cells
 *  @param configBlock A block that takes the cell and object for that cell to display
 *
 *  @return This datasource object
 */
- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController cellIdentifier:(NSString *)cellId configureCellBlock:(TableViewCellConfigureBlock)configBlock;

/**
 *  Find the object held by the data source at given index path. For arrays, this uses the indexPath.row and for FRC it uses the objectAtIndexPath: method
 *
 *  @param indexPath The index
 *
 *  @return The object at the given index path
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
