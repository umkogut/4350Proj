//
//  MenuItem.m
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

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
