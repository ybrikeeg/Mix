//
//  MockData.h
//  Mix
//
//  Created by Kirby Gee on 11/30/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockData : NSObject
+ (MockData *) sharedObj;
- (NSArray *)getUpcomingActivities;
- (NSArray *)getPastEvents;
- (NSArray *)getPersonLibrary;
@end
