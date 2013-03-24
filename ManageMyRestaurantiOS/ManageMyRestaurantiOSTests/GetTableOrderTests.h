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

@property TableOrder *testTableOrder;
@property ItemOrder *order;
@property NSInteger nOrdersBefore;
@property NSInteger nOrdersAfter;
@property NSInteger nOrdersCleaned;
@property NSMutableArray *result;
@property ItemOrder *resultOrder;

- (void)tableOrderTests;

@end