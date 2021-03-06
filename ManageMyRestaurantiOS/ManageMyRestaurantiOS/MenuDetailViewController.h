//
//  MenuDetailViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuItem;

@interface MenuDetailViewController : UITableViewController
@property (strong, nonatomic) MenuItem *menuItem;
@property (strong, nonatomic) NSMutableArray *categoriesList;
@property (nonatomic) BOOL returnFromEdit;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *isVegCell;

@end
