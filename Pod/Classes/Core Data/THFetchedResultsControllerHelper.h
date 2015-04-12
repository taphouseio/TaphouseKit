//
//  THFetchedResultsControllerHelper.h
//  TaphouseKit
//
//  Created by Jared Sorge on 7/26/14.
//  Copyright (c) 2014 Taphouse Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreData;

@interface THFetchedResultsControllerHelper : NSObject <NSFetchedResultsControllerDelegate>
/**
 *  Controls the CRUD operations of a table view backed by an NSFetchedResultsController. Mostly a boilerplate helper.
 *
 *  @param tableView The UITableView to be assigned.
 *
 *  @return self
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  Controls the CRUD operations of a collection view backed by an NSFetchedResultsController. Mostly a boilerplate helper.
 *
 *  @param tableView The UICollectionView to be assigned.
 *
 *  @return self
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
@end
