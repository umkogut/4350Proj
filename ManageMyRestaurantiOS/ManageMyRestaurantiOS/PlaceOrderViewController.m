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
    if (_tableOrder != tableOrder) {
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
    NSDictionary *menuList = [jsonParser objectWithString:responseString];
    NSLog(@"%@", menuList);
    
    [self.dataController clearMenu];
    
    NSArray *categories = [menuList objectForKey:@"categories"];
    for (NSDictionary *category in categories) {
        [self.dataController addCategory:[category objectForKey:@"name"]];
    }
    
    NSArray *menu = [menuList objectForKey:@"menu"];
    for (NSDictionary *item in menu) {
        MenuItem *newItem = [[MenuItem alloc] initWithName:[item objectForKey:@"name"]
                                                  category:[item objectForKey:@"category"]
                                               description:[item objectForKey:@"description"]
                                                     price:[item objectForKey:@"price"]
                                              isVegetarian:[[item objectForKey:@"isVeg"] boolValue]];
        [self.dataController addMenuItem:newItem];
    }
    
    [self.tableView reloadData];
    
}

- (IBAction)save:(id)sender
{
    
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
    int offset = 0;
    
    for (int section = indexPath.section; section > 0; section--)
    {
        offset += [self.menuTable numberOfRowsInSection:section];
    }
    
    MenuItem *selectedItem = [self.dataController.masterMenuItemList objectAtIndex:(offset + indexPath.row)];
    
    NSLog(selectedItem.name);
    
    //server will want JSON like:
//    {
//        "Orders" : [
//                    { "menuItem" : menuID, "tableNum" : tableID, "groupNum" : 0, "comments" : "" },
//                    { "menuItem" : menuID, "tableNum" : tableID, "groupNum" : 0, "comments" : "" }
//                   ]
//    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Tab bar controller delegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    UITabBarItem *vctab = viewController.tabBarItem;
    
    if ([vctab.title isEqual:@"Place Orders"]) {
        self.dataController = [[MenuItemDataController alloc] init];
        [self.tableView reloadData];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

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

@end
