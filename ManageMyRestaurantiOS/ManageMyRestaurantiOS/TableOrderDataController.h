//
//  TableOrderDataController.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemOrder;
@class TableOrder;

@interface TableOrderDataController : NSObject

@property (nonatomic) NSMutableArray *tableOrderList;
@property (nonatomic) NSMutableArray *tablesList;

- (NSInteger)numTables;
- (NSInteger)numOrdersByTable:(NSInteger)tableNum;
- (NSInteger)numOrdersByIndex:(NSUInteger)index;
- (void)addTable:(NSInteger)tableNum;
- (void)addSalesTable:(NSInteger)tableNum;
- (void)addOrder:(NSInteger)tableNum
                :(ItemOrder *)order;
- (NSMutableArray *)getListInCategory:(NSInteger)tableNum
                                     :(NSString *)category;
- (TableOrder *)objectInListAtIndex:(NSUInteger)index;
- (ItemOrder *)orderInListAtIndex:(NSInteger)tableNum
                                 :(NSUInteger)index;
- (NSString *)tableInListAtIndex:(NSInteger)tableNum;
- (void)clearTable:(NSInteger)tableNum;
- (void)clearAllTable;

@end
