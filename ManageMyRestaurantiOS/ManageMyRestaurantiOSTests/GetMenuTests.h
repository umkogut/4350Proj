//
//  GetMenuTests.h
//  ManageMyRestaurantiOS
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "MenuItem.h"

@interface GetMenuTests : SenTestCase
/* {
    TestMenuItem *testItem;
    NSMutableArray *testList;
} */

@property MenuItem *testItem;

- (void)testCreateItem;
- (void)testNil;

@end
