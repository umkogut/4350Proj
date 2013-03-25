//
//  PlaceOrderViewController.h
//  ManageMyRestaurantiOS
//
//  Created by David Kogut on 2013-03-25.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "defines.h"
#import "MenuItem.h"
#import "MenuItemDataController.h"
#import "TableOrder.h"

@class MenuItemDataController;

@interface PlaceOrderViewController : UITableViewController <UITabBarControllerDelegate>

@property (strong, nonatomic) MenuItemDataController *dataController;
@property (strong, nonatomic) TableOrder *tableOrder;
@property (strong, nonatomic) IBOutlet UITableView *menuTable;

- (IBAction)save:(id)sender;

@end
