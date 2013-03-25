//
//  TableOrder.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemOrder;

@interface TableOrder : NSObject

@property (nonatomic) NSInteger tableNum;
@property (nonatomic) NSMutableArray *orderList;

- (NSInteger)numOrders;
- (void)addOrder:(ItemOrder *)order;
//- (void)addTable:(NSInteger)tableNum;
- (NSMutableArray *)getListInCategory:(NSString *)category;
- (ItemOrder *)objectInListAtIndex:(NSUInteger)index;
//- (NSString *)tableInListAtIndex:(NSUInteger)index;
- (void)clearOrders;

- (id)initWithTableNum:(NSInteger)tableNum;

@end
