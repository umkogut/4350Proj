//
//  SalesMasterViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "SalesMasterViewController.h"
#import "SalesDetailViewController.h"
#import "ItemOrder.h"
#import "TableOrder.h"
#import "TableOrderDataController.h"
#import "defines.h"

@interface SalesMasterViewController ()

@end

@implementation SalesMasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib
{
    self.dataController = [[TableOrderDataController alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshOrders];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refreshOrders];

    SalesDetailViewController *salesDetailViewController = (SalesDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.detailViewController = salesDetailViewController;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }

    TableOrder *table = [self.dataController objectInListAtIndex:indexPath.section];
    NSString *tableNum = [NSString stringWithFormat:@"Table %i", table.tableNum];
    [[cell textLabel] setText:tableNum];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //TableOrder *table = [self.dataController objectInListAtIndex:section];
    return [NSString stringWithFormat:@"%s", ""];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        TableOrder *table = [self.dataController.tableOrderList objectAtIndex:[self.tableView indexPathForSelectedRow].section];

        self.detailViewController.table = table;
    }
}

@end
