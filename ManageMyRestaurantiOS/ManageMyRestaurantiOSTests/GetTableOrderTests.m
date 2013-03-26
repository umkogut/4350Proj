//
//  GetTableOrderTests.m
//  ManageMyRestaurantiOS
//
//  Created by Tiago Araujo on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "GetTableOrderTests.h"
#import "TableOrder.h"
#import "ItemOrder.h"

@implementation GetTableOrderTests

- (void)setUp
{
    [super setUp];
    
    ItemOrder *order;
    
    self.table = [[TableOrder alloc] initWithTableNum:1];
    
    order = [[ItemOrder alloc] initWithName:@"Salad"
                                    orderID:5
                                   category:@"Appetizer"
                                   groupNum:1
                                 isComplete:NO
                                   comments:@"Greens"];
    [self.table addOrder:order];
    
    order = [[ItemOrder alloc] initWithName:@"Fries"
                                    orderID:3
                                   category:@"Appetizer"
                                   groupNum:2
                                 isComplete:NO
                                   comments:nil];
    [self.table addOrder:order];
    
    order = [[ItemOrder alloc] initWithName:@"Burger"
                                    orderID:10
                                   category:@"Entrees"
                                   groupNum:1
                                 isComplete:NO
                                   comments:@"Beef"];
    [self.table addOrder:order];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateTable {
    TableOrder *newTable = [[TableOrder alloc] initWithTableNum:-1];
    
    STAssertNil(newTable, @"Table with a negative table number was allocated");
    
    newTable = [[TableOrder alloc] initWithTableNum:3];
    STAssertNotNil(newTable, @"Unable to create table");
    
    STAssertEquals([newTable numOrders], 0, @"There should be no orders");
    STAssertEquals([self.table numOrders], 3, @"Unable to add orders");
}

- (void)testAddingOrders {
    ItemOrder *order;
    
    STAssertEquals([self.table numOrders], 3, @"Unable to add orders");
    
    [self.table addOrder:nil];
    STAssertEquals([self.table numOrders], 3, @"Added nil order");
    
    [self.table addOrder:(ItemOrder *)@"object"];
    STAssertEquals([self.table numOrders], 3, @"Added an object that wasn't an order");
    
    order = [[ItemOrder alloc] initWithName:@"Cake"
                                    orderID:5
                                   category:@"Dessert"
                                   groupNum:1
                                 isComplete:YES
                                   comments:@"Yum"];
    [self.table addOrder:order];
    STAssertEquals([self.table numOrders], 4, @"Unable to add orders");
    
    [self.table clearOrders];
    STAssertEquals([self.table numOrders], 0, @"Unable to clear orders");
    
    [self.table addOrder:order];
    STAssertEquals([self.table numOrders], 1, @"Unable to add orders");
}

- (void)testGettingListByCategory {
    NSMutableArray *orderList;
    ItemOrder *order;
    
    STAssertEquals([self.table numOrders], 3, @"Unable to add orders");
    
    orderList = [self.table getListInCategory:@"Appetizer"];
    STAssertTrue([orderList count] == 2, @"Unable to get all appetizers");
    
    order = orderList[0];
    STAssertNotNil(order, @"Order is nil");
    STAssertEquals([order orderID], 5, @"Order ID not set correctly");
    STAssertEquals([order category], @"Appetizer", @"Order category not set correctly");
    STAssertEquals([order name], @"Salad", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"Greens", @"Order comments is not set correctly");
    
    order = orderList[1];
    STAssertNotNil(order, @"Order is nil");
    STAssertEquals([order orderID], 3, @"Order ID not set correctly");
    STAssertEquals([order category], @"Appetizer", @"Order category not set correctly");
    STAssertEquals([order name], @"Fries", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 2, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertNil([order comments], @"Order comments is not set correctly");
    
    order = [[ItemOrder alloc] initWithName:@"Test"
                                    orderID:7
                                   category:@"Appetizer"
                                   groupNum:1
                                 isComplete:YES
                                   comments:nil];
    [self.table addOrder:order];
    
    orderList = [self.table getListInCategory:@"Appetizer"];
    STAssertTrue([orderList count] == 3, @"Unable to get all appetizers");
    
    order = orderList[2];
    STAssertNotNil(order, @"Order is nil");
    STAssertEquals([order orderID], 7, @"Order ID not set correctly");
    STAssertEquals([order category], @"Appetizer", @"Order category not set correctly");
    STAssertEquals([order name], @"Test", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], YES, @"Order isComplete is not set correctly");
    STAssertNil([order comments], @"Order comments is not set correctly");
}

- (void)testGettingOrder {
    ItemOrder *order;
    
    order = [self.table objectInListAtIndex:0];
    STAssertNotNil(order, @"Order is nil");
    STAssertEquals([order orderID], 5, @"Order ID not set correctly");
    STAssertEquals([order category], @"Appetizer", @"Order category not set correctly");
    STAssertEquals([order name], @"Salad", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"Greens", @"Order comments is not set correctly");
    
    order = [self.table objectInListAtIndex:2];
    STAssertNotNil(order, @"Order is nil");
    STAssertEquals([order orderID], 10, @"Order ID not set correctly");
    STAssertEquals([order category], @"Entrees", @"Order category not set correctly");
    STAssertEquals([order name], @"Burger", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"Beef", @"Order comments is not set correctly");
    
    order = [[ItemOrder alloc] initWithName:@"Test"
                                    orderID:7
                                   category:@"Dessert"
                                   groupNum:1
                                 isComplete:YES
                                   comments:nil];
    [self.table addOrder:order];
    
    order = [self.table objectInListAtIndex:3];
    STAssertNotNil(order, @"Order is nil");
    STAssertEquals([order orderID], 7, @"Order ID not set correctly");
    STAssertEquals([order category], @"Dessert", @"Order category not set correctly");
    STAssertEquals([order name], @"Test", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], YES, @"Order isComplete is not set correctly");
    STAssertNil([order comments], @"Order comments is not set correctly");
}

@end
