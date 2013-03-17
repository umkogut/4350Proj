//
//  EditMenuDetailViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-11.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@interface EditMenuDetailViewController : UITableViewController

@property (strong, nonatomic) MenuItem *menuItem;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UISwitch *isVegetarianSwitch;

-(void)configureView;

@end
