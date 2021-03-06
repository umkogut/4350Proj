//
//  PlaceOrderMasterViewController.m
//  ManageMyRestaurantiOS
//
//  Created by David Kogut on 2013-03-25.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "PlaceOrderMasterViewController.h"
#import "PlaceOrderViewController.h"
#import "ItemOrder.h"
#import "defines.h"

@interface PlaceOrderMasterViewController ()

@end

@implementation PlaceOrderMasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshOrders];
    
    self.detailViewController = (PlaceOrderViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)refreshOrders {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/getOrders.json", serverURL]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
	[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        NSInteger tableNum = (NSInteger)([self.tableView indexPathForSelectedRow].section + 1);
        TableOrder *tableOrder = [[TableOrder alloc] initWithTableNum:tableNum];
        
        self.detailViewController.tableOrder = tableOrder;
    }
}

@end
