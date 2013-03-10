//
//  MenuDetailViewController.m
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "MenuDetailViewController.h"
#import "MenuItem.h"

@interface MenuDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;

@end

@implementation MenuDetailViewController

#pragma mark - Managing the detail item

// overriding the setter for a MenuItem
- (void)setMenuItem:(MenuItem *)newMenuItem
{
    if (_menuItem != newMenuItem) {
        _menuItem = newMenuItem;
        
        // update the view
        [self configureView];
    }
}

// configure the view
- (void)configureView
{
    // update the UI for the menu item
    MenuItem *item = self.menuItem;
    
    if (item) {
        self.nameLabel.text = item.name;
        self.categoryLabel.text = item.category;
        self.descriptionLabel.text = item.description;
        self.priceLabel.text = [NSString stringWithFormat:@"%g", item.price];
        
        if (item.isVegetarian) {
            self.isVegCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
