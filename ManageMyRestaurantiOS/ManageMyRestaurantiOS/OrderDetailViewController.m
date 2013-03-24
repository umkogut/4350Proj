//
//  OrderDetailViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-19.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderMasterViewController.h"
#import "ItemOrder.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

//@synthesize order;

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
}

- (void) didSelectOrder:(ItemOrder *)newOrder {
    self.order = newOrder;
    
    [self initializeView];
}

- (void)initializeView {
    if (self.order) {
        [self.orderIDLabel setText:[NSString stringWithFormat:@"%i", self.order.orderID]];
        [self.groupNumLabel setText:[NSString stringWithFormat:@"%i", self.order.groupNum]];
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
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeView];

//    if([self conformsToProtocol:@protocol(ItemOrderDelegate)])
//    {
//        NSLog(@"conformed");
//    }
    
//    OrderMasterViewController *master = [[OrderMasterViewController alloc] init];
//    master.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*  NOT SURE IF WE NEED

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

    NOT SURE IF WE NEED END */
 
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


/*     NOT SURE IF WE NEED

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
//}


@end
