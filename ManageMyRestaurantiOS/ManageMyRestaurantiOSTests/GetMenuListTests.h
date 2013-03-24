//
//  GetMenuListTests.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-23.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "MenuItemDataController.h"

@interface GetMenuListTests : SenTestCase

@property (nonatomic, retain) MenuItemDataController *menuDataController;

- (void)testMenuItem;
- (void)testCategory;

@end
