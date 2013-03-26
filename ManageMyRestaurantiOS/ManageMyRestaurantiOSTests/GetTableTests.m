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

    ItemOrder *order;
    
    self.tableDataController = [[TableOrderDataController alloc] init];
    [self.tableDataController addTable:1];
    [self.tableDataController addTable:3];
    
    order = [[ItemOrder alloc] initWithName:@"salad"
                                    orderID:1
                                   category:@"appetizer"
                                   groupNum:0
                                 isComplete:YES
                                   comments:@"no greens"];
    [self.tableDataController addOrder:1 :order];
    
    order = [[ItemOrder alloc] initWithName:@"burger"
                                    orderID:3
                                   category:@"entree"
                                   groupNum:0
                                 isComplete:NO
                                   comments:@"extra patty"];
    [self.tableDataController addOrder:1 :order];
    
    order = [[ItemOrder alloc] initWithName:@"cake"
                                    orderID:2
                                   category:@"dessert"
                                   groupNum:0
                                 isComplete:NO
                                   comments:nil];
    [self.tableDataController addOrder:1 :order];
    
    order = [[ItemOrder alloc] initWithName:@"fries"
                                    orderID:4
                                   category:@"entree"
                                   groupNum:0
                                 isComplete:NO
                                   comments:@"extra crispy"];
    [self.tableDataController addOrder:3 :order];
    
    order = [[ItemOrder alloc] initWithName:@"hot dog"
                                    orderID:5
                                   category:@"entree"
                                   groupNum:1
                                 isComplete:NO
                                   comments:@"no onions"];
    [self.tableDataController addOrder:3 :order];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateTableList {
    TableOrderDataController *tableList = [[TableOrderDataController alloc] init];
    
    STAssertNotNil(tableList, @"Unable to create table list");
    
    STAssertNotNil(self.tableDataController, @"Unable to create data controller");
    STAssertTrue([self.tableDataController numTables] == 2, @"Unable to create all the tables");
    
    STAssertTrue([self.tableDataController numOrdersByTable:1] == 3, @"Unable to create all order for table 1");
    STAssertTrue([self.tableDataController numOrdersByTable:3] == 2, @"Unable to create all order for table 3");
    STAssertTrue([self.tableDataController numOrdersByIndex:0] == 3, @"Unable to create all order for table 1");
    STAssertTrue([self.tableDataController numOrdersByIndex:1] == 2, @"Unable to create all order for table 3");
    
    [self.tableDataController clearAllTable];
    STAssertTrue([self.tableDataController numTables] == 0, @"Unable to remove all tables");
}

- (void)testAddTable {
    STAssertTrue([self.tableDataController numTables] == 2, @"Unable to create all the tables");
    
    [self.tableDataController addTable:2];
    STAssertTrue([self.tableDataController numTables] == 3, @"Unable to create new table");
    
    [self.tableDataController addTable:4];
    STAssertTrue([self.tableDataController numTables] == 4, @"Unable to create new table");
    
    [self.tableDataController clearAllTable];
    STAssertTrue([self.tableDataController numTables] == 0, @"Unable to remove all tables");
    
    [self.tableDataController addTable:1];
    STAssertTrue([self.tableDataController numTables] == 1, @"Unable to create new table");
    
    [self.tableDataController addTable:3];
    STAssertTrue([self.tableDataController numTables] == 2, @"Unable to create new table");
}

- (void)testGetTable {
    TableOrder *table;
    ItemOrder *order;
    
    STAssertTrue([self.tableDataController numTables] == 2, @"Unable to create all the tables");
    
    table = [self.tableDataController objectInListAtIndex:0];
    STAssertTrue([table tableNum] == 1, @"Unable to retrieve table");
    
    order = [table objectInListAtIndex:0];
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 1, @"Order ID not set correctly");
    STAssertEquals([order category], @"appetizer", @"Order category not set correctly");
    STAssertEquals([order name], @"salad", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], YES, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"no greens", @"Order comment is not set correctly");
    
    table = [self.tableDataController objectInListAtIndex:1];
    STAssertTrue([table tableNum] == 3, @"Unable to retrieve table");
    
    order = [table objectInListAtIndex:1];
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 5, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"hot dog", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"no onions", @"Order comment is not set correctly");
    
    [self.tableDataController addTable:4];
    STAssertTrue([self.tableDataController numTables] == 3, @"Unable to create new table");
    
    table = [self.tableDataController objectInListAtIndex:2];
    STAssertTrue([table tableNum] == 4, @"Unable to retrieve table");
}

- (void)testAddOrder {
    ItemOrder *order;
    
    STAssertTrue([self.tableDataController numTables] == 2, @"Unable to create all the tables");
    
    STAssertTrue([self.tableDataController numOrdersByTable:1] == 3, @"Unable to create all order for table 1");
    
    order = [[ItemOrder alloc] initWithName:@"fries"
                                    orderID:6
                                   category:@"entree"
                                   groupNum:1
                                 isComplete:NO
                                   comments:@"extra crispy"];
    [self.tableDataController addOrder:1 :order];
    STAssertTrue([self.tableDataController numOrdersByTable:1] == 4, @"Unable to create new order for table 1");
    
    order = [self.tableDataController orderInListAtIndex:1 :3];
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 6, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"fries", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 1, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"extra crispy", @"Order comment is not set correctly");
    
    [self.tableDataController clearTable:1];
    STAssertEquals([self.tableDataController numOrdersByTable:1], 0, @"Unable to remove table");
    
    order = [[ItemOrder alloc] initWithName:@"fries"
                                    orderID:6
                                   category:@"entree"
                                   groupNum:1
                                 isComplete:NO
                                   comments:@"extra crispy"];
    [self.tableDataController addOrder:1 :order];
    STAssertTrue([self.tableDataController numOrdersByTable:1] == 1, @"Unable to create new order for table 1");
}

- (void)testGetOrder {
    ItemOrder *order;
    
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
    
    order = [self.tableDataController orderInListAtIndex:3 :0];
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 4, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"fries", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([order comments], @"extra crispy", @"Order comment is not set correctly");
    
    order = [[ItemOrder alloc] initWithName:@"hot dog"
                                    orderID:7
                                   category:@"entree"
                                   groupNum:0
                                 isComplete:NO
                                   comments:nil];
    [self.tableDataController addOrder:3 :order];
    STAssertTrue([self.tableDataController numOrdersByTable:3] == 3, @"Unable to create new order for table 3");
    
    order = [self.tableDataController orderInListAtIndex:3 :2];
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 7, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"hot dog", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertNil([order comments], @"Order comment is not set correctly");
}

- (void)testGetOrderByCategory {
    ItemOrder *order;
    NSMutableArray *orderList;
    
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
    
    order = [[ItemOrder alloc] initWithName:@"hot dog"
                                    orderID:6
                                   category:@"entree"
                                   groupNum:0
                                 isComplete:NO
                                   comments:nil];
    [self.tableDataController addOrder:3 :order];
    STAssertTrue([self.tableDataController numOrdersByTable:3] == 3, @"Unable to create new order for table 3");
    
    orderList = [self.tableDataController getListInCategory:3 :@"entree"];
    order = orderList[2];
    
    STAssertNotNil(order, @"Unable to create item order");
    STAssertEquals([order orderID], 6, @"Order ID not set correctly");
    STAssertEquals([order category], @"entree", @"Order category not set correctly");
    STAssertEquals([order name], @"hot dog", @"Order name is not set correctly");
    STAssertEquals([order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertNil([order comments], @"Order comment is not set correctly");
    
    [self.tableDataController clearTable:3];
    STAssertEquals([self.tableDataController numOrdersByTable:3], 0, @"Unable to remove table");
    
    orderList = [self.tableDataController getListInCategory:3 :@"entree"];
    STAssertTrue([orderList count] == 0, @"Unable to create item order");
}

@end
