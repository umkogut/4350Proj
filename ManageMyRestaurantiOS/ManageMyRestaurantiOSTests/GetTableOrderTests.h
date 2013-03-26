//
//  GetTableOrderTests.h
//  ManageMyRestaurantiOS
//
//  Created by Tiago Araujo on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "TableOrder.h"

@interface GetTableOrderTests : SenTestCase

@property TableOrder *table;

- (void)testCreateTable;
- (void)testAddingOrders;
- (void)testGettingListByCategory;
- (void)testGettingOrder;

@end