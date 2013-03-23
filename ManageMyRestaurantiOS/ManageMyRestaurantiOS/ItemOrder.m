//
//  ItemOrder.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "ItemOrder.h"

@implementation ItemOrder

- (id)initWithName:(NSString *)name
          orderID:(NSInteger)orderID
         category:(NSString *)category
         groupNum:(NSInteger)groupNum
       isComplete:(BOOL)isComplete
         comments:(NSString *)comments {
    
    self = [super init];
    
    if (self) {
        _name = name;
        _orderID = orderID;
        _category = category;
        _groupNum = groupNum;
        _isComplete = isComplete;
        _comments = comments;
        return self;
    }
    return nil;
}

@end
