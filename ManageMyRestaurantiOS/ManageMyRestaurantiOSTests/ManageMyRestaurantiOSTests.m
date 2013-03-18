//
//  ManageMyRestaurantiOSTests.m
//  ManageMyRestaurantiOSTests
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "ManageMyRestaurantiOSTests.h"
#import "MenuItemTest.h"

@implementation ManageMyRestaurantiOSTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in ManageMyRestaurantiOSTests");
    
    NSString *name = @"testName";
    NSString *category = @"testCategory";
    NSString *description = @"This is a test description";
    NSDecimalNumber *price = [[NSDecimalNumber alloc] initWithDouble:0.99];
    BOOL isVeg = NO;
    
    MenuItemTest *item = [[MenuItemTest alloc] initWithName:name
                                                   category:category
                                                description:description
                                                      price:price
                                               isVegetarian:isVeg];
    
    STAssertNotNil(item, @"Unable to create test Menu item");
    STAssertEquals([item name], @"testName", @"Test Menu item name not set correctly");
    STAssertEquals([item category], @"testCategory", @"Test Menu item category not set correctly");
    STAssertEquals([item description], @"This is a test description", @"Test Menu item description not set correctly");
    STAssertEqualObjects([item price], [[NSDecimalNumber alloc] initWithDouble:0.99], @"Test Menu item price not set correctly");
    STAssertEquals([item isVegetarian], NO, @"Test Menu item isVegetarian not set correctly");
}

@end
