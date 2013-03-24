//
//  GetMenuListTests.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "GetMenuListTests.h"
#import "MenuItem.h"
#import "MenuItemDataController.h"

@implementation GetMenuListTests

- (void)setUp
{
    [super setUp];
    
    self.menuDataController = [[MenuItemDataController alloc] init];
    
    [self.menuDataController addCategory:@"Appetizer"];
    [self.menuDataController addCategory:@"Entrees"];
    [self.menuDataController addCategory:@"Dessert"];
    
    NSString *name = @"salad";
    NSString *category = @"Appetizer";
    NSString *description = @"greens";
    NSDecimalNumber *price = [[NSDecimalNumber alloc] initWithDouble:1.99];
    BOOL isVeg = YES;
    MenuItem *item;
    
    item = [[MenuItem alloc] initWithName:name
                                          category:category
                                       description:description
                                             price:price
                                      isVegetarian:isVeg];
    
    [self.menuDataController addMenuItem:item];
    
    name = @"burger";
    category = @"Entrees";
    description = @"beef";
    price = [[NSDecimalNumber alloc] initWithDouble:7.95];
    isVeg = NO;
    
    item = [[MenuItem alloc] initWithName:name
                                 category:category
                              description:description
                                    price:price
                             isVegetarian:isVeg];
    
    [self.menuDataController addMenuItem:item];
    
    name = @"cake";
    category = @"Dessert";
    description = @"sweeeet";
    price = [[NSDecimalNumber alloc] initWithDouble:2.45];
    isVeg = YES;
    
    item = [[MenuItem alloc] initWithName:name
                                 category:category
                              description:description
                                    price:price
                             isVegetarian:isVeg];
    
    [self.menuDataController addMenuItem:item];
    
    name = @"hot dog";
    category = @"Entrees";
    description = @"pork";
    price = [[NSDecimalNumber alloc] initWithDouble:4.95];
    isVeg = NO;
    
    item = [[MenuItem alloc] initWithName:name
                                 category:category
                              description:description
                                    price:price
                             isVegetarian:isVeg];
    
    [self.menuDataController addMenuItem:item];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testMenuItem  {
    MenuItem *item;
    NSMutableArray *itemList;
    
    STAssertTrue([self.menuDataController countOfList] == 4, @"Unable to create all menu items");
    
    item = [self.menuDataController objectInListAtIndex:0];
    
    STAssertNotNil(item, @"Unable to create Menu item");
    STAssertEquals([item name], @"salad", @"Unable to set menu item name");
    STAssertEquals([item category], @"Appetizer", @"Unable to set menu item category");
    STAssertEquals([item description], @"greens", @"Unable to set menu item description");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:1.99], @"Menu item price not set correctly");
    STAssertEquals([item isVegetarian], YES, @"Unable to change menu item to vegetarian");
    
    item = [self.menuDataController objectInListAtIndex:2];
    
    STAssertNotNil(item, @"Unable to create Menu item");
    STAssertEquals([item name], @"cake", @"Unable to set menu item name");
    STAssertEquals([item category], @"Dessert", @"Unable to set menu item category");
    STAssertEquals([item description], @"sweeeet", @"Unable to set menu item description");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:2.45], @"Menu item price not set correctly");
    STAssertEquals([item isVegetarian], YES, @"Unable to change menu item to vegetarian");
    
    MenuItem *newItem = [[MenuItem alloc] initWithName:@"newItem"
                                 category:@"Dessert"
                              description:@"new dessert"
                                    price:[[NSDecimalNumber alloc] initWithDouble:5.75]
                             isVegetarian:NO];
    [self.menuDataController addMenuItem:newItem];
    
    STAssertTrue([self.menuDataController countOfList] == 5, @"Unable to create all menu items");
    
    item = [self.menuDataController objectInListAtIndex:4];
    
    STAssertNotNil(item, @"Unable to create Menu item");
    STAssertEquals([item name], @"newItem", @"Unable to set menu item name");
    STAssertEquals([item category], @"Dessert", @"Unable to set menu item category");
    STAssertEquals([item description], @"new dessert", @"Unable to set menu item description");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:5.75], @"Menu item price not set correctly");
    STAssertEquals([item isVegetarian], NO, @"Unable to change menu item to vegetarian");
    
    itemList = [self.menuDataController getListInCategory:1];
    item = itemList[0];
    
    STAssertNotNil(item, @"Unable to create Menu item");
    STAssertEquals([item name], @"burger", @"Unable to set menu item name");
    STAssertEquals([item category], @"Entrees", @"Unable to set menu item category");
    STAssertEquals([item description], @"beef", @"Unable to set menu item description");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:7.95], @"Menu item price not set correctly");
    STAssertEquals([item isVegetarian], NO, @"Unable to change menu item to vegetarian");
    
    item = itemList[1];
    
    STAssertNotNil(item, @"Unable to create Menu item");
    STAssertEquals([item name], @"hot dog", @"Unable to set menu item name");
    STAssertEquals([item category], @"Entrees", @"Unable to set menu item category");
    STAssertEquals([item description], @"pork", @"Unable to set menu item description");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:4.95], @"Menu item price not set correctly");
    STAssertEquals([item isVegetarian], NO, @"Unable to change menu item to vegetarian");
    
    [self.menuDataController clearMenu];
    
    STAssertTrue([self.menuDataController countOfList] == 0, @"Unable to remove all menu items");
    
    [self.menuDataController addMenuItem:newItem];
    item = [self.menuDataController objectInListAtIndex:0];
    
    STAssertTrue([self.menuDataController countOfList] == 1, @"Unable to create all menu items");
    
    STAssertNotNil(item, @"Unable to create Menu item");
    STAssertEquals([item name], @"newItem", @"Unable to set menu item name");
    STAssertEquals([item category], @"Dessert", @"Unable to set menu item category");
    STAssertEquals([item description], @"new dessert", @"Unable to set menu item description");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:5.75], @"Menu item price not set correctly");
    STAssertEquals([item isVegetarian], NO, @"Unable to change menu item to vegetarian");
}

- (void)testCategory  {
    STAssertEquals([self.menuDataController numCategories], 3, @"Unable to create all categories");
    STAssertEquals([self.menuDataController categoryAtIndex:0], @"Appetizer", @"Unable to create Appetizer category");
    STAssertEquals([self.menuDataController categoryAtIndex:1], @"Entrees", @"Unable to create Entrees category");
    STAssertEquals([self.menuDataController categoryAtIndex:2], @"Dessert", @"Unable to create Dessert category");
    
    [self.menuDataController addCategory:@"New Category"];
    
    STAssertEquals([self.menuDataController numCategories], 4, @"Unable to create all categories");
    STAssertEquals([self.menuDataController categoryAtIndex:3], @"New Category", @"Unable to create Appetizer category");
    
    [self.menuDataController clearMenu];
    
    STAssertEquals([self.menuDataController numCategories], 0, @"Unable to remove all categories");
    
    [self.menuDataController addCategory:@"Appetizer"];
    
    STAssertEquals([self.menuDataController numCategories], 1, @"Unable to create all categories");
    STAssertEquals([self.menuDataController categoryAtIndex:0], @"Appetizer", @"Unable to create Appetizer category");
}

@end
