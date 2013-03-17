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
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *row = [NSString stringWithFormat:@"%d", [self.category selectedRowInComponent:0] + 1];
    
    NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                             self.itemName.text, @"name",
                             row, @"category",
                             self.description.text, @"description",
                             self.price.text, @"price",
                             @"TRUE", @"isVeg",
                             @"", @"image",
                             nil];
    NSString *jsonCommand = [jsonWriter stringWithObject:json];
    
    //NSLog(jsonCommand);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/addMenuItem", serverURL]];
    
    //Production
    //NSURL *url = [NSURL URLWithString:@"http://ec2-54-234-208-213.compute-1.amazonaws.com:6543/addMenuItem"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    //[request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonCommand  dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self];
    [request startSynchronous];
    
    NSString *JsonData = [request responseString];
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonObject = [jsonParser objectWithString:JsonData];
    NSInteger retVal = [[jsonObject objectForKey:@"isSuccess"] integerValue];
    
    if (retVal == 1)
    {
        //success
        
    }
    else
    {
        //failed - can't know why yet. Will work that out later
        UIAlertView *failedMsg = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Adding new menu item failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failedMsg show];
    }
    
    NSLog([request responseString]);
}

- (IBAction)add:(id)sender {
}


@end
