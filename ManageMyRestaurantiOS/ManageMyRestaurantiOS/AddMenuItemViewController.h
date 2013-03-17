//
//  AddMenuItemViewController.h
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-12.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICustomSwitch.h"
#import "ASIHttpRequest/ASIFormDataRequest.h"
#import "SBJson.h"

@interface AddMenuItemViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSArray *categories;
}

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UIPickerView *category;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UICustomSwitch *vegetarian;

- (IBAction)addMenuItem:(id)sender;




@end
