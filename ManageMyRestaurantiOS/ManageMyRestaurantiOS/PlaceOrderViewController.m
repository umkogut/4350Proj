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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
