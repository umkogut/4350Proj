//
//  MenuItem.h
//  ManageMyRestaurantiOS
//
//  Created by Amandusia Chmieluk on 2013-03-09.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger *menuID;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSDecimalNumber *price;
@property BOOL isVegetarian;

-(id)initWithName:(NSString *)name menuID:(NSInteger *)menuID category:(NSString *)category description:(NSString *)description price:(NSDecimalNumber *)price isVegetarian:(BOOL)isVegetarian;

@end
