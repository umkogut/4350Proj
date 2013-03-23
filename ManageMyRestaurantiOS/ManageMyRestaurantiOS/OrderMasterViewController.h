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

//@protocol ItemOrderDelegate <NSObject>
//
//-(void) didSelectOrder:(ItemOrder *) newOrder;
//
//@end

@interface OrderMasterViewController : UITableViewController

@property (retain, nonatomic) TableOrderDataController *dataController;
//@property (nonatomic, retain) IBOutlet OrderDetailViewController *detailViewController;
@property (strong, nonatomic) OrderDetailViewController *detailViewController;

//@property (nonatomic,retain) id<ItemOrderDelegate> delegate;

@end
