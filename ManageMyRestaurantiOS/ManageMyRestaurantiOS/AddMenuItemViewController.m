//
//  AddMenuItemViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-12.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "AddMenuItemViewController.h"

@interface AddMenuItemViewController ()

@end

@implementation AddMenuItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    categories = [[NSArray alloc] initWithObjects:@"Appetizer", @"Entree", @"Dessert", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return categories.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [categories objectAtIndex:row];
}

- (IBAction)addMenuItem:(id)sender {
    NSInteger row = [self.category selectedRowInComponent:0];
    NSString *strPrintRepeat = [categories objectAtIndex:row];
    
    NSURL *url = [NSURL URLWithString:@"http://ec2-54-234-208-213.compute-1.amazonaws.com:6543"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:self.itemName.text forKey:@"menuItem[name]"];
    [request setPostValue:self.price.text forKey:@"menuItem[price"];
    [request setPostValue:self.description.text forKey:@"menuItem[description]"];
    [request setPostValue:strPrintRepeat forKey:@"menuItem[category]"];
    [request setPostValue:FALSE forKey:@"menuItem[isVeg]"];
    
    [request setDelegate:self];
    [request startAsynchronous];
}
@end
