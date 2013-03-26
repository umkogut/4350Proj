//
//  SalesMasterViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@class ItemOrder;
@class TableOrderDataController;
@class SalesDetailViewController;

@interface SalesMasterViewController : UITableViewController

@property (retain, nonatomic) TableOrderDataController *dataController;
@property (strong, nonatomic) SalesDetailViewController *detailViewController;

@end
