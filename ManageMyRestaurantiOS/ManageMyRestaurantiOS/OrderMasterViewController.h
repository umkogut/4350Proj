//
//  OrderMasterViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@class ItemOrder;
@class TableOrderDataController;
@class OrderDetailViewController;

@interface OrderMasterViewController : UITableViewController

@property (retain, nonatomic) TableOrderDataController *dataController;
@property (strong, nonatomic) OrderDetailViewController *detailViewController;

@end
