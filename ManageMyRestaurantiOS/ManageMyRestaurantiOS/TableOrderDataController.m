//
//  TableOrderDataController.m
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import "TableOrderDataController.h"
#import "TableOrder.h"
#import "ItemOrder.h"

@implementation TableOrderDataController

- (id)init {
    self = [super init];
    
    if (self) {
        _tableOrderList = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

- (NSInteger)numTables {
    return [self.tableOrderList count];
}

- (NSInteger)numOrdersByTable:(NSInteger)tableNum {
    for (TableOrder *table in self.tableOrderList) {
        if (table.tableNum == tableNum) {
            return [table numOrders];
        }
    }
    return -1;
}

- (NSInteger)numOrdersByIndex:(NSUInteger)index {
    TableOrder *table = [self.tableOrderList objectAtIndex:index];
    return table.numOrders;
}

- (void)addTable:(NSInteger)tableNum {
    BOOL exists = NO;
    
    for (TableOrder *table in self.tableOrderList) {
        if (table.tableNum == tableNum) {
            exists = YES;
            break;
        }
    }
    
    if (!exists) {
        TableOrder *newTable = [[TableOrder alloc] initWithTableNum:tableNum];
        [self.tableOrderList addObject:newTable];
    }
}

-(void)addSalesTable:(NSInteger)tableNum {
    TableOrder *newTable = [[TableOrder alloc] initWithTableNum:tableNum];
    [self.tableOrderList addObject:newTable];
    [newTable addTable:tableNum];
}

- (void)addOrder:(NSInteger)tableNum
                :(ItemOrder *)order {
    for (TableOrder *table in self.tableOrderList) {
        if (table.tableNum == tableNum) {
            [table addOrder:order];
            break;
        }
    }
}

- (NSMutableArray *)getListInCategory:(NSInteger)tableNum
                         :(NSString *)category {
    for (TableOrder *table in self.tableOrderList) {
        if (table.tableNum == tableNum) {
            return [table getListInCategory:category];
            break;
        }
    }
    return nil;
}

- (TableOrder *)objectInListAtIndex:(NSUInteger)index {
    return [self.tableOrderList objectAtIndex:index];
}

- (ItemOrder *)orderInListAtIndex:(NSInteger)tableNum
                                     :(NSUInteger)index {
    for (TableOrder *table in self.tableOrderList) {
        if (table.tableNum == tableNum) {
            return [table objectInListAtIndex:index];
            break;
        }
    }
    return nil;
}

- (NSString *)tableInListAtIndex:(NSInteger)tableNum {
    return [self.tablesList objectAtIndex:tableNum];
}

- (void)clearTable:(NSInteger)tableNum {
    for (TableOrder *table in self.tableOrderList) {
        if (table.tableNum == tableNum) {
            [table clearOrders];
        }
    }
}

- (void)clearAllTable {
    [self.tableOrderList removeAllObjects];
}

@end
