//
//  GetTableTests.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class TableOrderDataController;

@interface GetTableTests : SenTestCase

@property (nonatomic, retain) TableOrderDataController *tableDataController;

- (void)testCreateItem;

@end
