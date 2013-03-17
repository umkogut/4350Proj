//
//  MenuMasterViewControlViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "MenuMasterViewController.h"
#import "MenuDetailViewController.h"
#import "MenuItemDataController.h"
#import "MenuItem.h"

/*
@interface MenuMasterViewControlViewController ()

@end
*/

@implementation MenuMasterViewController

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

-(void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    
    NSURL *url = [NSURL URLWithString:@"http://ec2-54-234-208-213.compute-1.amazonaws.com:6543/getMenu.json"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
    self.dataController = [[MenuItemDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
     
     UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
     self.navigationItem.rightBarButtonItem = addButton;
     self.detailViewController = (testDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
     */
}
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
        NSString *name = [item objectForKey:@"name"];
        
        NSInteger index = [[item objectForKey:@"category"] integerValue]-1;
        NSString *category = [self.dataController categoryAtIndex:index];
        NSString *description = [item objectForKey:@"description"];
        NSDecimalNumber *price = [item objectForKey:@"price"];
        BOOL isVeg = [[item objectForKey:@"isVeg"] boolValue];
        
        MenuItem *item = [[MenuItem alloc] initWithName:name
                                               category:category
                                            description:description
                                                  price:price
                                           isVegetarian:isVeg];
        [self.dataController addMenuItem:item];
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View   

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataController numCategories];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *list = [self.dataController getListInCategory:section];
    
    return [list count];
}

// populates each cell with data for the Menu
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    
    static NSString *CellIdentifier = @"MenuItemCell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableArray *sectionList = [self.dataController getListInCategory:indexPath.section];    
    MenuItem *itemAtIndex = [sectionList objectAtIndex:indexPath.row];    
    
    [[cell textLabel] setText:itemAtIndex.name];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.dataController.categoryList objectAtIndex:section];
}

/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 [_objects removeObjectAtIndex:indexPath.row];
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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
 
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
 NSDate *object = _objects[indexPath.row];
 self.detailViewController.detailItem = object;
 }
 }
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ShowMenuItemDetails"]) {
        
        MenuDetailViewController *detailViewController = [segue destinationViewController];
        
        NSMutableArray *listInCategory = [self.dataController getListInCategory:[self.tableView indexPathForSelectedRow].section];
        detailViewController.menuItem = [listInCategory objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
