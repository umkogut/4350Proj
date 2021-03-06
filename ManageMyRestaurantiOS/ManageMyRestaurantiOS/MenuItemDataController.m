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
        [self initializeDefaultCategoriesList];
        return self;
    }
    return nil;
}

// initializes the default list
-(void)initializeDefaultDataList {
    NSMutableArray *defaultList = [[NSMutableArray alloc] init];
    self.masterMenuItemList = defaultList;
}

// initialize the default categories list
-(void)initializeDefaultCategoriesList {
    NSMutableArray *defaultList = [[NSMutableArray alloc] init];
    self.categoryList = defaultList;
}

// get number of categories
-(NSInteger)numCategories {
    return [self.categoryList count];
}

// adds a new category to the list
-(void)addCategory:(NSString *)newCategory {
    if (newCategory != nil) {
        [self.categoryList addObject:newCategory];
    }
}

// get the list of menu items in a given category
-(NSMutableArray *)getListInCategory:(NSUInteger)index {
    NSString *category = [self.categoryList objectAtIndex:index];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (MenuItem *item in self.masterMenuItemList) {
        if ([item.category isEqual:category]) {
            [result addObject:item];
        }
    }
    
    return result;
}



// must override default so new list will be mutable
-(void)setMasterMenuItemList:(NSMutableArray *)newList {
    if (_masterMenuItemList != newList) {
        _masterMenuItemList = [newList mutableCopy];
    }
}

-(void)setCategoryList:(NSMutableArray *)categoryList {
    if(_categoryList != categoryList) {
        _categoryList = [categoryList mutableCopy];
    }
}

-(NSString *)categoryAtIndex:(NSUInteger)index {
    return [self.categoryList objectAtIndex:index];
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
    if (menuItem != nil && [menuItem isKindOfClass:[MenuItem class]]) {
        [self.masterMenuItemList addObject:menuItem];
    }
}

-(void)clearMenu {
    [self.categoryList removeAllObjects];
    [self.masterMenuItemList removeAllObjects];
}

@end
