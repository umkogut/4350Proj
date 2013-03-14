//
//  MenuItemDataController.h
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MenuItem;

@interface MenuItemDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterMenuItemList;
@property (nonatomic, copy) NSMutableArray *categoryList;

-(NSUInteger)countOfList;
-(MenuItem *)objectInListAtIndex:(NSUInteger)index;
-(void)addMenuItem:(MenuItem *)menuItem;

-(NSInteger)numCategories;
-(NSMutableArray *)getListInCategory:(NSInteger)index;

@end
