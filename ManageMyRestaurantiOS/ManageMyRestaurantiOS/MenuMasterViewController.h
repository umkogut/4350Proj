//
//  MenuMasterViewControlViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuItemDataController;
@class MenuDetailViewController;


@interface MenuMasterViewController : UITableViewController

@property (strong, nonatomic) MenuItemDataController *dataController;
@property (strong, nonatomic) MenuDetailViewController *detailViewController;

- (IBAction)cancel:(UIStoryboardSegue *)segue;


@end
