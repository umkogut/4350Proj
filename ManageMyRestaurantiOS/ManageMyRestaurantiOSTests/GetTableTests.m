//
//  GetTableTests.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "GetTableTests.h"
#import "ItemOrder.h"
#import "TableOrderDataController.h"
#import "TableOrder.h"

@implementation GetTableTests

- (void)setUp
{
    [super setUp];
    
    NSInteger orderID = 1;
    NSString *category = @"appetizer";
    NSString *name = @"salad";
    NSInteger groupNum = 0;
    BOOL isComplete = YES;
    NSString *comments = @"no greens";
    ItemOrder *order;
    
    self.tableDataController = [[TableOrderDataController alloc] init];
    [self.tableDataController addTable:1];
    [self.tableDataController addTable:3];
    
    order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
    [self.tableDataController addOrder:1 :order];
    
    orderID = 3;
    category = @"entree";
    name = @"burger";
    groupNum = 0;
    isComplete = NO;
    comments = @"extra patty";
    
    order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
    [self.tableDataController addOrder:1 :order];
    
    orderID = 2;
    category = @"dessert";
    name = @"cake";
    groupNum = 0;
    isComplete = NO;
    comments = nil;
    
    order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
    [self.tableDataController addOrder:1 :order];
    
    orderID = 4;
    category = @"entree";
    name = @"fries";
    groupNum = 0;
    isComplete = NO;
    comments = @"extra crispy";
    
    order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
    [self.tableDataController addOrder:3 :order];
    
    orderID = 5;
    category = @"entree";
    name = @"hot dog";
    groupNum = 1;
    isComplete = NO;
    comments = @"no onions";
    
    order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
    [self.tableDataController addOrder:3 :order];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateItem {
    ItemOrder *order;
    NSMutableArray *orderList;
    TableOrder *table;
    
    STAssertNotNil(self.tableDataController, @"Unable to create data controller");
    STAssertTrue([self.tableDataController numTables] == 2, @"Unable to create all the tables");
    
    STAssertTrue([self.tableDataController numOrdersByTable:1] == 3, @"Unable to create all order for table 1");
    STAssertTrue([self.tableDataController numOrdersByTable:3] == 2, @"Unable to create all order for table 3");
    STAssertTrue([self.tableDataController numOrdersByIndex:0] == 3, @"Unable to create all order for table 1");
    STAssertTrue([self.tableDataController numOrdersByIndex:1] == 2, @"Unable to create all order for table 3");
    
    orderList = [self.tableDataController getListInCategory:1 :@"appetizer"];
    order = orderList[0];
    
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 1, @"Order ID not set correctly");
    STAssertEquals([order category], @"appetizer", @"Order category not set correctly");
    STAssertEquals([order name], @"salad", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], YES, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"no greens", @"Order comment is not set correctly");
    
    table = [self.tableDataController objectInListAtIndex:0];
    
    STAssertEquals(table.tableNum, 1, @"Table number not set correctly");
    order = [self.tableDataController orderInListAtIndex:1 :1];
    
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 3, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"burger", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"extra patty", @"Order comment is not set correctly");
    
    order = [self.tableDataController orderInListAtIndex:1 :2];
    
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 2, @"Order ID not set correctly");
    STAssertEquals([order category], @"dessert", @"Order category not set correctly");
    STAssertEquals([order name], @"cake", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertNil([order comments], @"Order comment is not set correctly");
    
    table = [self.tableDataController objectInListAtIndex:1];
    
    STAssertTrue(table.tableNum == 3, @"Table number not set correctly");
    
    orderList = [self.tableDataController getListInCategory:3 :@"entree"];
    order = orderList[0];
    
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 4, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"fries", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"extra crispy", @"Order comment is not set correctly");
    
    order = orderList[1];
    
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 5, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"hot dog", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"no onions", @"Order comment is not set correctly");

    [self.tableDataController clearTable:3];
    
    STAssertEquals([self.tableDataController numOrdersByTable:3], 0, @"Unable to remove table");
    
    [self.tableDataController clearAllTable];
    
    STAssertTrue([self.tableDataController numTables] == 0, @"Unable to remove all tables");
}

@end
