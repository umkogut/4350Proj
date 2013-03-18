//
//  MenuItemTest.m
//  ManageMyRestaurantiOS
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "MenuItemTest.h"

@implementation MenuItemTest

-(id)initWithName:(NSString *)name
         category:(NSString *)category
      description:(NSString *)description
            price:(NSDecimalNumber *)price
     isVegetarian:(BOOL)isVegetarian {
    
    self = [super init];
    
    if (self) {
        _name = name;
        _category = category;
        _description = description;
        _price = price;
        _isVegetarian = isVegetarian;
        return self;
    }
    return nil;
}

@end
