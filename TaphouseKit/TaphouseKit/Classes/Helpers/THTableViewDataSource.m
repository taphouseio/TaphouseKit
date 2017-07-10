//
//  THTableViewDataSource.m
//  Pods
//
//  Created by Jared Sorge on 3/6/15.
//
//

#import "THTableViewDataSource.h"
@import CoreData;

@interface THTableViewDataSource ()
@property (nonatomic, strong) NSArray *displayArray;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock cellConfigBlock;
@end

@implementation THTableViewDataSource
#pragma mark - API
- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellId configureCellBlock:(TableViewCellConfigureBlock)configBlock
{
    self = [super init];
    if (self) {
        self.displayArray = items;
        self.cellIdentifier = cellId;
        self.cellConfigBlock = configBlock;
    }
    return self;
}

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController cellIdentifier:(NSString *)cellId configureCellBlock:(TableViewCellConfigureBlock)configBlock
{
    self = [super init];
    if (self) {
        self.fetchedResultsController = fetchedResultsController;
        self.cellIdentifier = cellId;
        self.cellConfigBlock = configBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    id item;
    
    if (self.fetchedResultsController) {
        item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    } else if (self.displayArray) {
        item = self.displayArray[indexPath.row];
    }
    
    return item;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    if (self.fetchedResultsController) {
        rows = [self.fetchedResultsController fetchedObjects].count;
    } else if (self.displayArray) {
        rows = self.displayArray.count;
    }
    
    return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = 1;
    
    if (self.fetchedResultsController) {
        sections = [self.fetchedResultsController sections].count;
    }
    
    return sections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.cellConfigBlock(cell, item);
    
    return cell;
}
@end
