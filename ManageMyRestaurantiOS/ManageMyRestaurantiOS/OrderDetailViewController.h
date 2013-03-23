//
//  OrderDetailViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-19.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMasterViewController.h"

@class ItemOrder;

@interface OrderDetailViewController : UITableViewController <UISplitViewControllerDelegate>//<UISplitViewControllerDelegate, ItemOrderDelegate>

@property (retain, nonatomic) ItemOrder *order;

@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *isCompleteCell;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

@end
