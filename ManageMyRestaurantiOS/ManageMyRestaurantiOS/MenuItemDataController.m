//
//  MenuItemDataController.m
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "MenuItemDataController.h"
#import "MenuItem.h"

@interface MenuItemDataController ()

-(void)initializeDefaultDataList;

@end


@implementation MenuItemDataController

// init
-(id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

// initializes the default list
-(void)initializeDefaultDataList {
    NSMutableArray *defaultList = [[NSMutableArray alloc] init];
    self.masterMenuItemList = defaultList;
    
    MenuItem *item = [[MenuItem alloc] initWithName:@"Test"];
    [self addMenuItem:item];
}

// must override default so new list will be mutable
-(void)setMasterMenuItemList:(NSMutableArray *)newList {
    if (_masterMenuItemList != newList) {
        _masterMenuItemList = [newList mutableCopy];
    }
}

// counts the number of items
-(NSUInteger)countOfList {
    return [self.masterMenuItemList count];
}

// gets the item at a given index
-(MenuItem *)objectInListAtIndex:(NSUInteger)index {
    return [self.masterMenuItemList objectAtIndex:index];
}

// adds a new item to the list (does not manipulate the database)
-(void)addMenuItem:(MenuItem *)menuItem {
    [self.masterMenuItemList addObject:menuItem];
}

@end
