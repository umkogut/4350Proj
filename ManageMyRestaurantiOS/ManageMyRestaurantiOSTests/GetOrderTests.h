//
//  GetOrderTests.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class ItemOrder;

@interface GetOrderTests : SenTestCase

@property (nonatomic, retain) ItemOrder *order;

- (void)testCreateItem;

@end
