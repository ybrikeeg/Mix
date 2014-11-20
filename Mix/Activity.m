//
//  Activity.m
//  Mix
//
//  Created by Kirby Gee on 11/18/14.
//  Copyright (c) 2014 Kirby Gee - Stanford Univeristy. All rights reserved.
//

#import "Activity.h"

@implementation Activity

- (instancetype)init{
   self = [super init];
   if (self) {
      self.activityJoined = NO;
   }
   
   return self;
}
@end
