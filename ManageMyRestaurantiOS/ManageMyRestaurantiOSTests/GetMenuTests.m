//
//  GetMenuTests.m
//  ManageMyRestaurantiOS
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "GetMenuTests.h"
#import "MenuItem.h"

@implementation GetMenuTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateItem
{
    NSDecimalNumber *price = [[NSDecimalNumber alloc] initWithDouble:0.99];
    MenuItem *item;
    
    item = [[MenuItem alloc] initWithName:@"testName"
                                 category:@"testCategory"
                              description:@"This is a test description"
                                    price:price
                             isVegetarian:NO];
    
    STAssertNotNil(item, @"Unable to create test Menu item");
    STAssertEquals([item name], @"testName", @"Test Menu item name not set correctly");
    STAssertEquals([item category], @"testCategory", @"Test Menu item category not set correctly");
    STAssertEquals([item description], @"This is a test description", @"Test Menu item description not set correctly");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:0.99], @"Test Menu item price not set correctly");
    STAssertEquals([item isVegetarian], NO, @"Test Menu item isVegetarian not set correctly");
}

- (void)testNil {
    NSDecimalNumber *price = [[NSDecimalNumber alloc] initWithDouble:0.99];
    MenuItem *item;
    
    item = [[MenuItem alloc] initWithName:nil
                                          category:@"testCategory"
                                       description:@"This is a test description"
                                             price:price
                             isVegetarian:NO];
    STAssertNil(item, @"Able to create menu item with nil data");
    
    item = [[MenuItem alloc] initWithName:@"testName"
                                          category:nil
                                       description:@"This is a test description"
                                             price:price
                                      isVegetarian:NO];
    STAssertNil(item, @"Able to create menu item with nil data");
    
    item = [[MenuItem alloc] initWithName:@"testName"
                                          category:@"testCategory"
                                       description:@"This is a test description"
                                             price:nil
                                      isVegetarian:NO];
    
    STAssertNil(item, @"Able to create menu item with nil data");
    
    item = [[MenuItem alloc] initWithName:@"testName"
                                 category:@"testCategory"
                              description:nil
                                    price:price
                             isVegetarian:NO];
    
    STAssertNotNil(item, @"Unable to create test Menu item");
    STAssertEquals([item name], @"testName", @"Test Menu item name not set correctly");
    STAssertEquals([item category], @"testCategory", @"Test Menu item category not set correctly");
    STAssertNil([item description], @"Test Menu item description not set correctly");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:0.99], @"Test Menu item price not set correctly");
    STAssertEquals([item isVegetarian], NO, @"Test Menu item isVegetarian not set correctly");
    
}

@end
