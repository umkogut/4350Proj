//
//  PlaceOrderMasterViewController.h
//  ManageMyRestaurantiOS
//
//  Created by David Kogut on 2013-03-25.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@class TableOrderDataController;
@class PlaceOrderViewController;


@interface PlaceOrderMasterViewController : UITableViewController

@property (retain, nonatomic) TableOrderDataController *dataController;
@property (strong, nonatomic) PlaceOrderViewController *detailViewController;

@end

