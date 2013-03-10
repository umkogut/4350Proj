//
//  MenuItem.m
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

-(id)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        _name = name;
    }
    return nil;
}

@end
