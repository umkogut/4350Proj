//
//  OrderDetailViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-19.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation OrderDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail order

- (void)setOrder:(ItemOrder *)newOrder {
    if (_order != newOrder) {
        _order = newOrder;
        
        [self initializeView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void) didSelectOrder:(ItemOrder *)newOrder {
    self.order = newOrder;
    
    [self initializeView];
}

- (void)initializeView {
    if (self.order) {
        [self.nameLabel setText:self.order.name];
        [self.categoryLabel setText:self.order.category];
        
        NSString *comment = self.order.comments;
        if ([comment isEqual:@""]) {
            [self.commentsLabel setText:@"None"];
        }
        else {
            [self.commentsLabel setText:self.order.comments];
        }        
        
        if (self.order.isComplete) {
            self.isCompleteCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            self.isCompleteCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.nameLabel setText:@"None"];
    [self.categoryLabel setText:@"None"];
    [self.commentsLabel setText:@"None"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self initializeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Tables", @"Tables");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
    
}

@end
