//
//  SalesDetailViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesMasterViewController.h"
#import "MenuItemDataController.h"
#import "MenuItem.h"
#import "TableOrder.h"
#import "ItemOrder.h"

@class TableOrder;
@class ItemOrder;

@interface SalesDetailViewController : UITableViewController <UITabBarControllerDelegate, UISplitViewControllerDelegate>

@property (retain, nonatomic) MenuItemDataController *dataController;
@property (retain, nonatomic) TableOrder *table;
@property (nonatomic) NSInteger orderItemCount;
@property (retain, nonatomic) NSMutableArray *itemsToRemove;

@property (weak, nonatomic) IBOutlet UITableViewCell *orderItem;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (strong, nonatomic) IBOutlet UITableView *orderTable;

- (IBAction)paySelectedItems:(id)sender;

@end
