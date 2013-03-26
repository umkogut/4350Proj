//
//  OrderMasterViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "OrderMasterViewController.h"
#import "OrderDetailViewController.h"
#import "ItemOrder.h"
#import "TableOrder.h"
#import "TableOrderDataController.h"
#import "defines.h"

@interface OrderMasterViewController ()

@end

@implementation OrderMasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    
    self.dataController = [[TableOrderDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self refreshOrders];

    OrderDetailViewController *orderDetailViewController = (OrderDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.detailViewController = orderDetailViewController;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshOrders];
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

// called when the ASIHTTPRequest is finished
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *responseString =[request responseString];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    responseString = [responseString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    NSLog(@"Response: %@", responseString);
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSArray *tableList = [jsonParser objectWithString:responseString];
    NSLog(@"%@", tableList);
    
    [self.dataController clearAllTable];
    
    for (NSDictionary *table in tableList) {
        NSInteger tableNum = [[table objectForKey:@"tableNum"] intValue];
        [self.dataController addTable:tableNum];
        
        if ([[table objectForKey:@"orders"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *order = [table objectForKey:@"orders"];
            
            ItemOrder *newOrder = [[ItemOrder alloc] initWithName:[order objectForKey:@"menuName"]
                                                          orderID:[[order objectForKey:@"orderID"] intValue]
                                                         category:[order objectForKey:@"category"]
                                                         groupNum:[[order objectForKey:@"groupNum"] intValue]
                                                       isComplete:[[order objectForKey:@"isComplete"] boolValue]
                                                         comments:[order objectForKey:@"comments"]];
            [self.dataController addOrder:tableNum :newOrder];

        } else {
            NSArray *orderList = [table objectForKey:@"orders"];
            for (NSDictionary *order in orderList) {
                ItemOrder *newOrder = [[ItemOrder alloc] initWithName:[order objectForKey:@"menuName"]
                                                              orderID:[[order objectForKey:@"orderID"] intValue]
                                                             category:[order objectForKey:@"category"]
                                                             groupNum:[[order objectForKey:@"groupNum"] intValue]
                                                           isComplete:[[order objectForKey:@"isComplete"] boolValue]
                                                             comments:[order objectForKey:@"comments"]];
                [self.dataController addOrder:tableNum :newOrder];
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataController numTables];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController numOrdersByIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    TableOrder *table = [self.dataController objectInListAtIndex:indexPath.section];
    ItemOrder *order = [table objectInListAtIndex:indexPath.row];
    [[cell textLabel] setText:order.name];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    TableOrder *table = [self.dataController objectInListAtIndex:section];
    return [NSString stringWithFormat:@"Table %i", table.tableNum];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        TableOrder *table = [self.dataController.tableOrderList objectAtIndex:[self.tableView indexPathForSelectedRow].section];
        ItemOrder *order = [table objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        self.detailViewController.order = order;
    }
}

@end
