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
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *description;
@property double price;
@property BOOL isVegetarian;

-(id)initWithName:(NSString *)name category:(NSString *)category description:(NSString *)description price:(double)price isVegetarian:(BOOL)isVegetarian;

@end
