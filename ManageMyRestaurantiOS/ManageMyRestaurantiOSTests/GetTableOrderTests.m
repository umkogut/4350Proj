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
    
    self.testTableOrder = [[TableOrder alloc] initWithTableNum:1];
    
    NSString *name = @"testName";
    NSInteger orderID = 100;
    NSString *category = @"Apperitizer";
    NSInteger groupNum = 1;
    BOOL isComplete = NO;
    NSString *comments = @"testComment";
    
    self.order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
    
    self.nOrdersBefore = [self.testTableOrder numOrders];
    
    [self.testTableOrder addOrder:self.order];
    
    self.nOrdersAfter = [self.testTableOrder numOrders];
    
    self.result = [[NSMutableArray alloc] init];
    
    self.result =[self.testTableOrder getListInCategory:@"Apperitizer"];
    
    self.resultOrder = [self.testTableOrder objectInListAtIndex:0];
    
    [self.testTableOrder clearOrders];
    
    self.nOrdersCleaned = [self.testTableOrder numOrders];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testOrderTests
{
    STAssertNotNil(self.testTableOrder, @"Table was not allocated");
    STAssertTrue(self.nOrdersBefore == 0, @"Number of orders wrong before the insertion");
    STAssertTrue(self.nOrdersAfter == 1, @"Number of orders wrong after the insertion");
    STAssertEquals(self.order, [self.result objectAtIndex:0], @"Orders is not returning right by category");
    STAssertEquals(self.order, self.resultOrder, @"The order returned is different than the first one");
    STAssertTrue(self.nOrdersCleaned == 0, @"Number of orders wrong after cleaning");
}

@end
