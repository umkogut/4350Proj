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
    
    NSString *name = @"testName";
    NSInteger orderID = 100;
    NSString *category = @"Apperitizer";
    NSInteger groupNum = 1;
    BOOL isComplete = NO;
    NSString *comments = @"testComment";
    
    //NSInteger tableNum = 1;
    //NSMutableArray *orderList = [[NSMutableArray alloc] init];
    
    ItemOrder *order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
    
    
    self.nOrdersBefore = [self.testTableOrder numOrders];
    NSLog(@" =BEFORE= %i", self.nOrdersBefore);
    
    [self.testTableOrder addOrder:order];
    
    self.nOrdersAfter = [self.testTableOrder numOrders];
    
    NSLog(@" ==AFTER== %i", self.nOrdersAfter);
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNumOrder
{
    //STAssertTrue(self.nOrdersBefore == 0, @"Number of orders wrong before the insertion");
    //STAssertTrue(self.nOrdersAfter == 1, @"Number of orders wrong after the insertion");
    
}

- (void)testAddOrder
{
    
}

- (void)testGetListsInCategory
{
    
}

- (void)testObjectList
{

}

@end
