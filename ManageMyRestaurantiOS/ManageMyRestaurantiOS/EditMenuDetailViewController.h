//
//  EditMenuDetailViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-11.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"
#import "ASIHttpRequest/ASIFormDataRequest.h"
#import "SBJson.h"

@interface EditMenuDetailViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) MenuItem *menuItem;
@property (strong, nonatomic) NSMutableArray *categoryList;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPickerView;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UISwitch *isVegetarianSwitch;
@property (nonatomic) NSInteger *menuID;

-(void)configureView;
-(void)editMenuItem:(NSString *)oldItemName withUpdatedItem:(MenuItem *)updatedItem;


- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
