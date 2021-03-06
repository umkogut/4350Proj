//
//  AddMenuItemViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Riley Draward on 2013-03-12.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "AddMenuItemViewController.h"
#import "defines.h"

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
    categories = [[NSArray alloc] initWithObjects:@"Appetizers", @"Entrees", @"Dessert", nil];
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
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *row = [NSString stringWithFormat:@"%d", [self.category selectedRowInComponent:0] + 1];
    NSString *vegValue = @"FALSE";
    if(self.vegetarian.value == 1.0) {
        vegValue = @"TRUE";
    }
    
    if(![self.itemName.text isEqualToString:@""] && ![self.description.text isEqualToString:@""] && ![self.price.text isEqualToString:@""]) {
        
        NSString *currencyRegex = @"[0-9]+(.[0-9][0-9]?)?";
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", currencyRegex];
        BOOL match = [test evaluateWithObject:self.price.text];
        
        if(match) {
            NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.itemName.text, @"name",
                                 row, @"category",
                                 self.description.text, @"description",
                                 self.price.text, @"price",
                                 vegValue, @"isVeg",
                                 @"", @"image",
                                 nil];
            NSString *jsonCommand = [jsonWriter stringWithObject:json];
        
            //NSLog(jsonCommand);
        
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/addMenuItem", serverURL]];
        
            //Production
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
        
            [request setRequestMethod:@"POST"];
            [request appendPostData:[jsonCommand  dataUsingEncoding:NSUTF8StringEncoding]];
        
            [request setDelegate:self];
            [request startAsynchronous];
        }
        else
        {
            UIAlertView *failedMsg = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Adding new menu item failed - Price must be of format 'x.xx'" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [failedMsg show];
        }
    }
    else
    {
        UIAlertView *failedMsg = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Adding new menu item failed - Name, Description and Price cannot be left empty." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failedMsg show];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *JsonData = [request responseString];
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonObject = [jsonParser objectWithString:JsonData];
    NSInteger retVal = [[jsonObject objectForKey:@"isSuccess"] integerValue];
    
    if (retVal == 1)
    {
        //success
        UIAlertView *successMsg = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Menu item successfully added!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [successMsg show];
        
        self.itemName.text = @"";
        self.description.text = @"";
        self.price.text = @"";
    }
    else
    {
        //failed - can't know why yet. Will work that out later
        UIAlertView *failedMsg = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Adding new menu item failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failedMsg show];
    }
    
    NSLog(@"%@",[request responseString]);
}

@end
