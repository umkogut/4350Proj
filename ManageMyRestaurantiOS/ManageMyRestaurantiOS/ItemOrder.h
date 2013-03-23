//
//  ItemOrder.h
//  ManageMyRestaurantiOS
//
//  Created by Rong Wu on 2013-03-18.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemOrder : NSObject

@property (nonatomic) NSInteger orderID;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger groupNum;
@property BOOL isComplete;
@property (nonatomic, copy) NSString *comments;

- (id)initWithName:(NSString *)name
           orderID:(NSInteger)orderID
          category:(NSString *)category
          groupNum:(NSInteger)groupNum
        isComplete:(BOOL)isComplete
          comments:(NSString *)comments;

@end
