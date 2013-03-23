//
//  TableOrder.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "TableOrder.h"
#import "ItemOrder.h"

@implementation TableOrder

- (id)initWithTableNum:(NSInteger)tableNum {
    
    self = [super init];
    
    if (self) {
        _tableNum = tableNum;
        _orderList = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

- (NSInteger)numOrders {
    return [self.orderList count];
}

- (void)addOrder:(ItemOrder *)order {
    [self.orderList addObject:order];
}

- (NSMutableArray *)getListInCategory:(NSString *)category {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (ItemOrder *order in self.orderList) {
        if ([order.category isEqualToString:category]) {
            [result addObject:order];
        }
    }
    
    return result;
}

- (ItemOrder *)objectInListAtIndex:(NSUInteger)index {
    return [self.orderList objectAtIndex:index];
}

- (void)clearOrders {
    [self.orderList removeAllObjects];
}

@end