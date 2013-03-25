//
//  OrderDetailViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-19.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMasterViewController.h"
#import "ItemOrder.h"

@class ItemOrder;

@interface OrderDetailViewController : UITableViewController <UITabBarControllerDelegate, UISplitViewControllerDelegate>

@property (retain, nonatomic) ItemOrder *order;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *isCompleteCell;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

@end
