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
#import "defines.h"

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

- (IBAction)refresh {
    [self refreshMenu];
}

-(void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    
    [self refreshMenu];
    
    self.dataController = [[MenuItemDataController alloc] init];
}

- (void)refreshMenu {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/getMenu.json", serverURL]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
	[request addRequestHeader:@"Accept" value:@"application/json"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"ShowMenuItemDetails"]) {
        
        MenuDetailViewController *detailViewController = [segue destinationViewController];
        
        NSMutableArray *listInCategory = [self.dataController getListInCategory:[self.tableView indexPathForSelectedRow].section];
        detailViewController.menuItem = [listInCategory objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailViewController.categoriesList = self.dataController.categoryList;
    }
}

@end
