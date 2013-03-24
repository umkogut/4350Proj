//
//  GetTableOrderTests.h
//  ManageMyRestaurantiOS
//
//  Created by Tiago Araujo on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "TableOrder.h"
#import "ItemOrder.h"

@interface GetTableOrderTests : SenTestCase

@property (nonatomic, retain) TableOrder *testTableOrder;
@property NSInteger nOrdersBefore;
@property NSInteger nOrdersAfter;

- (void)testNumOrder;
- (void)testAddOrder;
- (void)testGetListsInCategory;
- (void)testObjectList;

@end
