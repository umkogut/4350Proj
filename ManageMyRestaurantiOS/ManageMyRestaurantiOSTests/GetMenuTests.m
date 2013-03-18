//
//  GetMenuTests.m
//  ManageMyRestaurantiOS
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "GetMenuTests.h"
#import "TestMenuItem.h"

@implementation GetMenuTests

- (void)setUp
{
    [super setUp];
    
    NSString *name = @"testName";
    NSString *category = @"testCategory";
    NSString *description = @"This is a test description";
    NSDecimalNumber *price = [[NSDecimalNumber alloc] initWithDouble:0.99];
    BOOL isVeg = NO;
    
    self.testItem = [[TestMenuItem alloc] initWithName:name
                                              category:category
                                           description:description
                                                 price:price
                                          isVegetarian:isVeg];
    
    self.testList = [[NSMutableArray alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateItem
{    
    STAssertNotNil(self.testItem, @"Unable to create test Menu item");
    STAssertEquals([self.testItem name], @"testName", @"Test Menu item name not set correctly");
    STAssertEquals([self.testItem category], @"testCategory", @"Test Menu item category not set correctly");
    STAssertEquals([self.testItem description], @"This is a test description", @"Test Menu item description not set correctly");
    STAssertEqualObjects([self.testItem price], [[NSDecimalNumber alloc] initWithDouble:0.99], @"Test Menu item price not set correctly");
    STAssertEquals([self.testItem isVegetarian], NO, @"Test Menu item isVegetarian not set correctly");
}

- (void)testGetMenu
{
    [self.testList addObject:self.testItem];
    
    STAssertTrue([self.testList count] == 1, @"Menu item not added to list");
}

@end
