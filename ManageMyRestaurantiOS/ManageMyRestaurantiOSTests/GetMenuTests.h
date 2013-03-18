//
//  GetMenuTests.h
//  ManageMyRestaurantiOS
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "TestMenuItem.h"

@interface GetMenuTests : SenTestCase
/* {
    TestMenuItem *testItem;
    NSMutableArray *testList;
} */

@property TestMenuItem *testItem;
@property NSMutableArray *testList;

- (void)testCreateItem;
- (void)testGetMenu;

@end
