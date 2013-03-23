//
//  EditMenuDetailViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-11.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "EditMenuDetailViewController.h"
#import "defines.h"

@interface EditMenuDetailViewController ()

@end

@implementation EditMenuDetailViewController

// displays the menu item's current details
-(void)configureView {
    MenuItem *item = self.menuItem;
    
    [self.nameTextField setText:item.name];    
    [self.descriptionTextField setText:item.description];    
    [self.priceTextField setText:[NSString stringWithFormat:@"%0.2f", [item.price floatValue]]];    
    [self.isVegetarianSwitch setOn:item.isVegetarian];
    
    NSInteger index = [self.categoryList indexOfObject:self.menuItem.category];
    [self.categoryPickerView selectRow:index inComponent:0 animated:NO];
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)done:(id)sender {
    NSLog(@"done called");
    
    NSString *name = [self.nameTextField text];
//    NSInteger categoryIndex = [self.categoryPickerView selectedRowInComponent:0];
    NSString *categoryID = [NSString stringWithFormat:@"%d", [self.categoryPickerView selectedRowInComponent:0] + 1];   // NOTE:  Must use categoryID because we are
//    NSString *category = [self.categoryList objectAtIndex:categoryIndex];
    NSString *description = [self.descriptionTextField text];
    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:[self.priceTextField text]];
    BOOL isVegetarian = [self.isVegetarianSwitch isOn];
    
    MenuItem *updatedItem = [[MenuItem alloc] initWithName:name category:categoryID description:description price:price  isVegetarian:isVegetarian];
    [self editMenuItemDetails:self.menuItem.name withUpdatedItem:updatedItem];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)editMenuItemDetails:(NSString *)oldItemName withUpdatedItem:(MenuItem *)updatedItem {
    NSLog(@"editing");
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    
    NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                          updatedItem.name, @"name",
                          updatedItem.category, @"category",
                          updatedItem.description, @"description",
                          updatedItem.price, @"price",
                          [NSNumber numberWithBool:updatedItem.isVegetarian] , @"isVeg",
                          @"", @"image",
                          oldItemName, @"prevItemName",
                          nil];
    NSLog(@"%@", json);
    NSString *jsonCommand = [jsonWriter stringWithObject:json];
    
    NSLog(@"%@", jsonCommand);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"%@/editMenuItem.json", serverURL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    [request setRequestMethod:@"POST"];
    [request appendPostData:[jsonCommand  dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *JsonData = [request responseString];
    NSLog(@"Return value: %@", JsonData);
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonObject = [jsonParser objectWithString:JsonData];
    NSInteger retVal = [[jsonObject objectForKey:@"isSuccess"] integerValue];
    
    if (retVal == 1)
    {
        //success
        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have successfully edited the menu item" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [success show];
        
    }
    else
    {
        //failed - can't know why yet. Will work that out later
        UIAlertView *failedMsg = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Editing failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failedMsg show];
    }
}

#pragma mark - Table view data source

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark - UIPickerView data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.categoryList.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [self.categoryList objectAtIndex:row];    
    
    return title;
}
@end
