//
//  GetOrderTests.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "GetOrderTests.h"
#import "ItemOrder.h"

@implementation GetOrderTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateItem {
    
    ItemOrder *order = [[ItemOrder alloc] initWithName:@"test item"
                                         orderID:1
                                        category:@"app"
                                        groupNum:0
                                      isComplete:NO
                                        comments:@"comment"];
    
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 1, @"Order ID not set correctly");
    STAssertEquals([order category], @"app", @"Order category not set correctly");
    STAssertEquals([order name], @"test item", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"comment", @"Order comment is not set correctly");
}

- (void)testNil {
    ItemOrder *order;
    
    order = [[ItemOrder alloc] initWithName:nil
                                    orderID:1
                                   category:@"app"
                                   groupNum:0
                                 isComplete:NO
                                   comments:@"comment"];
    STAssertNil(order, @"Able to create order item with nil data");
    
    order = [[ItemOrder alloc] initWithName:@"test item"
                                    orderID:1
                                   category:nil
                                   groupNum:0
                                 isComplete:NO
                                   comments:@"comment"];
    STAssertNil(order, @"Able to create order item with nil data");
    
    order = [[ItemOrder alloc] initWithName:@"test item"
                                    orderID:-1
                                   category:@"app"
                                   groupNum:0
                                 isComplete:NO
                                   comments:@"comment"];
    STAssertNil(order, @"Able to create order item with negative order ID");
    
    order = [[ItemOrder alloc] initWithName:@"test item"
                                    orderID:1
                                   category:@"app"
                                   groupNum:-1
                                 isComplete:NO
                                   comments:@"comment"];
    STAssertNil(order, @"Able to create order item with negative group number");
    
    order = [[ItemOrder alloc] initWithName:@"test item"
                                    orderID:1
                                   category:@"app"
                                   groupNum:0
                                 isComplete:NO
                                   comments:nil];
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 1, @"Order ID not set correctly");
    STAssertEquals([order category], @"app", @"Order category not set correctly");
    STAssertEquals([order name], @"test item", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertNil([order comments], @"Order comment is not set correctly");
}

@end
