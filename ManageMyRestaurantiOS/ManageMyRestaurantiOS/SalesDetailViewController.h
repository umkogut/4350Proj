//
//  SalesDetailViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesMasterViewController.h"
#import "TableOrder.h"
#import "ItemOrder.h"

@class TableOrder;
@class ItemOrder;

@interface SalesDetailViewController : UITableViewController <UITabBarControllerDelegate, UISplitViewControllerDelegate>

@property (retain, nonatomic) TableOrder *table;

@property (weak, nonatomic) IBOutlet UITableViewCell *orderItem;


@end
