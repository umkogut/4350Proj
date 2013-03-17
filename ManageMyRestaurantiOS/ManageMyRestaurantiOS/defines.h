//
//  defines.h
//  ManageMyRestaurantiOS
//
//  Created by Marko Kalic on 3/17/13.
//  Copyright (c) 2013 Group6Comp4350. All rights reserved.
//

#ifndef ManageMyRestaurantiOS_defines_h
#define ManageMyRestaurantiOS_defines_h

#ifdef DEBUG
#define serverURL @"http://ec2-23-22-29-187.compute-1.amazonaws.com:6543" //development
#else
#define serverURL @"http://ec2-54-234-208-213.compute-1.amazonaws.com:6543" //production
#endif

#endif
