//
//  MenuItemDataController.h
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@class MenuItem;

@interface MenuItemDataController : NSObject

@property (nonatomic) NSMutableArray *masterMenuItemList;
@property (nonatomic) NSMutableArray *categoryList;

-(NSUInteger)countOfList;
-(MenuItem *)objectInListAtIndex:(NSUInteger)index;
-(void)addMenuItem:(MenuItem *)menuItem;
-(void)addCategory:(NSString *)category;

-(NSInteger)numCategories;
-(NSMutableArray *)getListInCategory:(NSUInteger)index;
-(NSString *)categoryAtIndex:(NSUInteger)index;

-(void)clearMenu;

@end
