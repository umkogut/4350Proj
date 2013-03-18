//
//  MenuItemTest.h
//  ManageMyRestaurantiOS
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface MenuItemTest : SenTestCase

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSDecimalNumber *price;
@property BOOL isVegetarian;

-(id)initWithName:(NSString *)name category:(NSString *)category description:(NSString *)description price:(NSDecimalNumber *)price isVegetarian:(BOOL)isVegetarian;

@end
