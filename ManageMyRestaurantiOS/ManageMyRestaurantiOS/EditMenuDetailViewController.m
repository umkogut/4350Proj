//
//  EditMenuDetailViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-11.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "EditMenuDetailViewController.h"

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
    NSLog(@"editing menu item details");
    
    NSString *name = [self.nameTextField text];
    NSInteger categoryIndex = [self.categoryPickerView selectedRowInComponent:0];
    NSString *category = [self.categoryList objectAtIndex:categoryIndex];
    NSString *description = [self.descriptionTextField text];
    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:[self.priceTextField text]];
    BOOL isVegetarian = [self.isVegetarianSwitch isOn];
    
    MenuItem *updatedItem = [[MenuItem alloc] initWithName:name category:category description:description price:price  isVegetarian:isVegetarian];
    
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)editMenuItemDetails:(MenuItem *)updatedItem {
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
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
//    NSString *category = self.menuItem.category;
//    if ([title isEqual:category]) {
//        [self.categoryPickerView selectRow:row inComponent:component animated:NO];
//    }
    
    
    return title;
}
@end
