//
//  SalesDetailViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "SalesDetailViewController.h"
#import "SalesMasterViewController.h"
#import "TableOrder.h"
#import "ItemOrder.h"
#import "defines.h"
#import "ASIFormDataRequest.h"

@interface SalesDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation SalesDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail order

- (void)setTable:(TableOrder *)newTable {
    if (_table != newTable) {
        _table = newTable;
        
        [self initializeView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void) didSelectTable:(TableOrder *)newTable {
    self.table = newTable;
    [self initializeView];
}

- (void)initializeView {
    self.itemsToRemove = [[NSMutableArray alloc] init];
    self.dataController = [[MenuItemDataController alloc] init];
    [self.tableView reloadData];
    [self refreshMenu];
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

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UISplitViewController *)viewController
//{
//    NSArray *list = viewController.childViewControllers;
//    if ([viewController class] == [OrderDetailViewController class]) {
//        NSLog(@"Order Details");
//    }
//}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"I'm landscape");
    }
    else
    {
        NSLog(@"I'm portrait");
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.table.numOrders;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    if([self.table.orderList count] > 0) {
        if(self.orderItemCount >= [self.table.orderList count]) {
            self.orderItemCount = 0;
        }
        
        NSString *orderInfo = [[self.table.orderList objectAtIndex:self.orderItemCount] name];
        [[cell textLabel] setText:orderInfo];
        self.orderItemCount = self.orderItemCount + 1;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.itemsToRemove addObject:[self.table.orderList objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.itemsToRemove removeObject:[self.table.orderList objectAtIndex:indexPath.row]];
}

- (IBAction)paySelectedItems:(id)sender {
    NSArray *itemsChosen = [self.orderTable indexPathsForSelectedRows];
    NSString *jsonCommand = [NSString stringWithFormat:@"[{\"numItems\":%@}",[NSString stringWithFormat:@"%i", [itemsChosen count]]];
    NSIndexPath *itemPath;
    int loc = 0;
        
    if([itemsChosen count] > 0) {
        //request
        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        
        for (int i = 0; i < [itemsChosen count]; i++) {
            //get MenuItem id #
            BOOL isRemoved = FALSE;
            NSInteger *menuid = 0;
            itemPath = [itemsChosen objectAtIndex:i];
            
            NSString *itemName = [[[self.orderTable cellForRowAtIndexPath:itemPath] textLabel] text];
            
            for (int j = 0; j < self.dataController.countOfList; j++) {
                if([itemName isEqualToString:[[self.dataController objectInListAtIndex:j] name]]) {
                    menuid = [[self.dataController objectInListAtIndex:j] menuID];
                }
            }
            
            for (int k = 0; k < [self.table.orderList count]; k++) {
                if([[[self.table.orderList objectAtIndex:k] name] isEqualToString:itemName] && !isRemoved) {
                    [self.itemsToRemove addObject:[self.table.orderList objectAtIndex:k]];
                    [self.table.orderList removeObjectAtIndex:k];
                    isRemoved = TRUE;
                }
            }
            
            for (int l = 0; l < [self.itemsToRemove count]; l++) {
                if([[[self.itemsToRemove objectAtIndex:l] name] isEqualToString:itemName]) {
                    loc = l;
                }
            }
            
            //NSLog(itemName);
            
            NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSString stringWithFormat:@"%i",self.table.tableNum], @"table",
                                  [NSString stringWithFormat:@"%i",(NSInteger)menuid], @"menuItem",
                                  [NSString stringWithFormat:@"%i",[[self.itemsToRemove objectAtIndex:loc] groupNum]], @"group",
                                  [NSString stringWithFormat:@"%i",[[self.itemsToRemove objectAtIndex:loc] orderID]], @"order",
                                  nil];
            
            if(jsonCommand != NULL)
                jsonCommand = [NSString stringWithFormat:@"%@,{\"orderItem\":%@}", jsonCommand, [jsonWriter stringWithObject:json]];
            else
                jsonCommand = [NSString stringWithFormat:@"{\"orderItem\":%@}",[jsonWriter stringWithObject:json]];
            
            //[self.itemsToRemove removeObjectAtIndex:loc];
            //[self.table.orderList removeObjectAtIndex:i];
        }
        [self.itemsToRemove removeAllObjects];
        
        jsonCommand = [NSString stringWithFormat:@"%@]", jsonCommand];
//        NSLog(jsonCommand);
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/payForItems", serverURL]];
        
        //Production
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        
        [request setRequestMethod:@"POST"];
        [request appendPostData:[jsonCommand  dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setDelegate:self];
        [request startAsynchronous];
    } else {
        UIAlertView *failedMsg = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"No items selected!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failedMsg show];
    }
}

- (void)refreshMenu
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/getMenu.json", serverURL]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
	[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startAsynchronous];
}

// called when the ASIHTTPRequest is finished
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString =[request responseString];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    responseString = [responseString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    //NSLog(@"Response: %@", responseString);
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *menuList = [jsonParser objectWithString:responseString];
    //NSLog(@"%@", menuList);
    
    [self.dataController clearMenu];
    
    if ([menuList count] > 0)
        //reloading the menu
    {
        NSArray *categories = [menuList objectForKey:@"categories"];
        for (NSDictionary *category in categories) {
            [self.dataController addCategory:[category objectForKey:@"name"]];
        }
        
        NSArray *menu = [menuList objectForKey:@"menu"];
        for (NSDictionary *item in menu) {
            MenuItem *newItem = [[MenuItem alloc] initWithName:[item objectForKey:@"name"]
                                                        menuID:(NSInteger *)[[item objectForKey:@"menuID"] intValue]
                                                      category:[item objectForKey:@"category"]
                                                   description:[item objectForKey:@"description"]
                                                         price:[item objectForKey:@"price"]
                                                  isVegetarian:[[item objectForKey:@"isVeg"] boolValue]];
            [self.dataController addMenuItem:newItem];
        }
        
        [self.tableView reloadData];
    }
    else
        //placed an order
    {
        [self refreshMenu];
        [self initializeView];
    }
}
@end
