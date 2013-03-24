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
    
    NSInteger orderID = 1;
    NSString *category = @"app";
    NSString *name = @"test item";
    NSInteger groupNum = 0;
    BOOL isComplete = NO;
    NSString *comments = @"comment";
    
    self.order = [[ItemOrder alloc] initWithName:name orderID:orderID category:category groupNum:groupNum isComplete:isComplete comments:comments];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateItem {
    STAssertNotNil(self.order, @"Unable to create item order");
    STAssertEquals([self.order orderID], 1, @"Order ID not set correctly");
    STAssertEquals([self.order category], @"app", @"Order category not set correctly");
    STAssertEquals([self.order name], @"test item", @"Order name is not set correctly");
    STAssertEquals([self.order groupNum], 0, @"Order group number not set correctly");
    STAssertEquals([self.order isComplete], NO, @"Order isComplete is not set correctly");
    STAssertEquals([self.order comments], @"comment", @"Order comment is not set correctly");
}

@end
