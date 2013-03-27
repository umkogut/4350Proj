//
//  PlaceOrderViewController.m
//  ManageMyRestaurantiOS
//
//  Created by David Kogut on 2013-03-25.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "PlaceOrderViewController.h"


@interface PlaceOrderViewController ()

@end

@implementation PlaceOrderViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTableOrder:(TableOrder *)tableOrder
{
    if (_tableOrder != tableOrder)
    {
        _tableOrder = tableOrder;
        [self refreshMenu];
    }
}

-(void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    
    self.dataController = [[MenuItemDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    NSLog(@"Response: %@", responseString);
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *menuList = [jsonParser objectWithString:responseString];
    NSLog(@"%@", menuList);
        
    [self.dataController clearMenu];
    
    if ([menuList count] > 0)
    //reloading the menu
    {    
        NSArray *categories = [menuList objectForKey:@"categories"];
        for (NSDictionary *category in categories) {
            [self.dataController addCategory:[category objectForKey:@"name"]];
        }
        
        NSArray *menu = [menuList objectForKey:@"menu"];
        for (NSDictionary *item in menu)
        {
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
        UIAlertView *successMsg = [[UIAlertView alloc] initWithTitle:@"Order Placed" message:@"Successfully placed orders" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [successMsg show];        
    }
}

- (IBAction)save:(id)sender
{
    NSArray *itemsChosen = [self.menuTable indexPathsForSelectedRows];
    MenuItem *selectedItem;
    NSIndexPath *itemPath;
    NSMutableArray *allSelections = [[NSMutableArray alloc] init];
    NSDictionary *indItem;
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSDictionary *json;
    NSMutableArray *itemsInSection;
    
    if ([itemsChosen count] > 0)
    {
        for (int i=1; i <= [itemsChosen count]; i++)
        {
            itemPath = [itemsChosen objectAtIndex:i-1];
            itemsInSection = [self.dataController getListInCategory: itemPath.section];
            selectedItem = [itemsInSection objectAtIndex:itemPath.row];
            
            indItem = [[NSDictionary alloc] init];
            indItem = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"", @"comments",
                       [NSNumber numberWithInteger: 0], @"groupNum",
                       [NSNumber numberWithInteger: self.tableOrder.tableNum], @"tableNum", 
                       [NSNumber numberWithInteger: (NSInteger)selectedItem.menuID], @"menuItem",
                       nil];
            
            [allSelections addObject:indItem];
        }
        
        json = [NSDictionary dictionaryWithObjectsAndKeys:
                allSelections, @"Orders",
                nil];
        
        NSString *jsonCommand = [jsonWriter stringWithObject:json];
        NSLog(@"jsonCommand\n%@", jsonCommand);
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/placedOrder.json", serverURL]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        
        [request setRequestMethod:@"POST"];
        [request appendPostData:[jsonCommand  dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setDelegate:self];
        [request startAsynchronous];
    }
    else
    {
        UIAlertView *failedMsg = [[UIAlertView alloc] initWithTitle:@"No items selected" message:@"Please select at least one item to add to the order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failedMsg show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataController numCategories];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *list = [self.dataController getListInCategory:section];    
    return [list count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.dataController.categoryList objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableArray *sectionList = [self.dataController getListInCategory:indexPath.section];
    MenuItem *itemAtIndex = [sectionList objectAtIndex:indexPath.row];
    
    [[cell textLabel] setText:itemAtIndex.name];
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Item selected");
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Item de-selected");
}

- (void)viewWillAppear:(BOOL)animated
{
    self.dataController = [[MenuItemDataController alloc] init];
    [self.tableView reloadData];
}

@end
