//
//  THModalSegue.m
//  TaphouseKit
//
//  Created by Jared Sorge on 2/12/15.
//  Copyright (c) 2015 Taphouse Software. All rights reserved.
//

#import "THModalSegue.h"

@interface THModalSegue ()
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation THModalSegue
#pragma mark - Overrides
- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:destination];
    self.navigationController.modalPresentationStyle = destination.modalPresentationStyle;
    
    return self;
}

- (void)perform
{
    [self.sourceViewController presentViewController:self.navigationController animated:YES completion:nil];
}
@end
